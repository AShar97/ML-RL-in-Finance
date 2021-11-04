#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests, json

def submit(submitterEmail,secret,key,submission_part,all_parts, data):
        
        submission = {
                    "assignmentKey": key,
                    "submitterEmail":  submitterEmail,
                    "secret":  secret,
                    "parts": {}
                  }
        second_part=''
        
        for part in all_parts:            
            if part in submission_part:
                submission["parts"][part] = {"output": data[part]}
            else:
                submission["parts"][part] = dict()

        response = requests.post('https://hub.coursera-apps.org/api/onDemandProgrammingScriptSubmissions.v1', data=json.dumps(submission))
            
        if response.status_code == 201:
            print ("Submission successful, please check on the coursera grader page for the status")
        else:
            print ("Something went wrong, please have a look at the reponse of the grader")
            print ("-------------------------")
            print (response.text)
            print ("-------------------------")


