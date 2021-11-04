#!/usr/bin/env python
# -*- coding: utf-8 -*-
#!/usr/bin/env python

import json
import logging
import multiprocessing
import os.path
import re
import requests
import sys
import time
import uuid


def idle_transloadit_server(args):
    result = requests.get('https://api2.transloadit.com/instances/bored')
    if result.status_code != 200:
        logging.error('Transloadit board instance API failure. Code: %s',
                      result.status_code)
        raise Exception('TransloadIt bored instances API failure.')

    if result.json()['ok'] != 'BORED_INSTANCE_FOUND':
        logging.error(
            'TransloadIt bord instances API did not find a bored instance. %s',
            result.json())
        raise Exception('No Bored Transloadit instance found.')
    return result.json()['host']


def setup_registration_parser(parser):
    'This is a helper function to coalesce all the common registration'
    'parameters for code reuse.'

    # constants for timeout ranges
    TIMEOUT_LOWER = 300
    TIMEOUT_UPPER = 1800

    parser.add_argument(
        'course',
        help='The course id to associate the grader. The course id is a '
        'gibberish string UUID. Given a course slug such as `developer-iot`, '
        'you can retrieve the course id by querying the catalog API. e.g.: '
        'https://api.coursera.org/api/onDemandCourses.v1?q=slug&'
        'slug=developer-iot')

    parser.add_argument(
        'item',
        help='The id of the item to associate the grader. The easiest way '
        'to find the item id is by looking at the URL in the authoring web '
        'interface. It is the last part of the URL, and is a short UUID.')

    parser.add_argument(
        'part',
        help='The id of the part to associate the grader.')

    parser.add_argument(
        '--additional_item_and_part',
        nargs=2,
        action='append',
        help='The next two args specify an item ID and part ID which will '
             'also be associated with the grader.')

    parser.add_argument(
        '--grader-cpu',
        type=int,
        choices=[1, 2],
        help='Amount of CPU your grader is allocated when grading '
             'submissions. You may choose from 1 or 2 full CPU cores. The '
             'default number is 1.')

    parser.add_argument(
        '--grader-memory-limit',
        type=int,
        choices=[1024, 2048, 3072, 4096],
        help='Amount of memory your grader is allocated when grading '
             'submissions. You may choose from 1024, 2048, 3072 or '
             '4096 MB. The default amount is 1024 MB.')

    parser.add_argument(
        '--grading-timeout',
        type=lambda v: utils.check_int_range(v, TIMEOUT_LOWER, TIMEOUT_UPPER),
        help='Amount of time allowed before your grader times out, in '
             'seconds. You may choose any value between 300 seconds and 1800 '
             'seconds.  The default time is 1200 seconds (20 minutes).')

    parser.add_argument(
        '--register-endpoint',
        default='https://api.coursera.org/api/gridExecutorCreationAttempts.v1',
        help='Override the endpoint used to register the graders after upload')

    parser.add_argument(
        '--update-part-endpoint',
        default='https://api.coursera.org/api/'
                'authoringProgrammingAssignments.v1',
        help='Override the endpoint used to update the assignment (draft)')

    parser.add_argument(
        '--update-part-action',
        default='setGridExecutorId',
        help='The name of the Naptime action called to update the assignment')


def parser(subparsers):
    "Build an argparse argument parser to parse the command line."

    # create the parser for the upload command.
    parser_upload = subparsers.add_parser(
        'upload',
        help='Upload a container to Coursera.',
        parents=[common.container_parser()])
    parser_upload.set_defaults(func=command_upload)

    setup_registration_parser(parser_upload)

    parser_upload.add_argument(
        '--temp-dir',
        default='/tmp',
        help='Temporary directory to use when exporting the container.')

    parser_upload.add_argument(
        '--file-name',
        help='File name to use when saving the docker container image. '
             'Defaults to the name of the container image.')

    parser_upload.add_argument(
        '--upload-to-requestbin',
        help='Pass the ID of a request bin to debug uploads!')

    parser_upload.add_argument(
        '--transloadit-template',
        default='7531c0b023f611e5aa2ecf267b4b90ee',
        help='The transloadit template to upload to.')

    parser_upload.add_argument(
        '--transloadit-account-id',
        default='05912e90e83346abb96c261bf458b615',
        help='The Coursera transloadit account id.')

    return parser_upload


