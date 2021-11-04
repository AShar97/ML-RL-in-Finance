clear; clc;

M = [2 3 4 5 7 10 20 30];

Y = [3.804	3.721	3.685	3.684	3.731	3.84	4.177	4.401
    3.615	3.619	3.654	3.702	3.807	3.954	4.284	4.449
    3.578	3.585	3.623	3.672	3.779	3.927	4.265	4.446
    3.614	3.576	3.568	3.583	3.649	3.771	4.115	4.325
    3.232	3.22	3.236	3.271	3.374	3.552	3.983	4.188
    3.162	3.145	3.158	3.193	3.3	3.497	4.02	4.28
    3.156	3.122	3.132	3.169	3.285	3.492	4.013	4.267
    2.996	2.996	3.013	3.044	3.139	3.327	3.925	4.294
    3.163	3.181	3.205	3.239	3.337	3.529	4.141	4.496
    3.175	3.191	3.221	3.262	3.368	3.556	4.14	4.519
    3.103	3.093	3.102	3.127	3.211	3.383	3.972	4.369
    3.045	3.027	3.037	3.067	3.165	3.357	3.954	4.314
    2.814	2.879	2.943	3.003	3.126	3.317	3.87	4.211
    2.426	2.571	2.703	2.824	3.038	3.302	3.86	4.151
    2.058	2.251	2.406	2.535	2.749	3.005	3.577	3.915
    2.376	2.536	2.672	2.792	3.002	3.261	3.816	4.113
    2.454	2.72	2.927	3.089	3.326	3.555	3.977	4.223
    2.575	2.878	3.082	3.225	3.41	3.59	4.024	4.3
    2.476	2.748	2.961	3.13	3.376	3.61	4.016	4.261
    2.592	2.892	3.088	3.227	3.422	3.636	4.093	4.307
    2.381	2.658	2.87	3.035	3.278	3.528	4.04	4.336
    2.192	2.509	2.739	2.915	3.178	3.465	4.028	4.283
    2.072	2.355	2.562	2.727	2.988	3.299	3.96	4.271
    1.56	1.939	2.244	2.494	2.874	3.248	3.786	3.979
    1.384	1.776	2.1	2.368	2.779	3.192	3.806	4.032
    1.275	1.539	1.776	1.989	2.349	2.761	3.498	3.878
    1.072	1.424	1.731	1.994	2.415	2.863	3.6	3.894
    1.224	1.497	1.743	1.966	2.349	2.799	3.625	3.952
    0.786	1.062	1.318	1.547	1.935	2.396	3.356	3.856
    0.827	1.075	1.315	1.538	1.929	2.396	3.323	3.745
    0.673	0.931	1.194	1.442	1.873	2.375	3.333	3.787
    0.781	1.078	1.346	1.59	2.018	2.537	3.566	4.024
    0.823	1.171	1.474	1.738	2.175	2.659	3.499	3.85
    0.598	0.898	1.175	1.425	1.853	2.358	3.342	3.806
    0.664	1.003	1.321	1.609	2.087	2.607	3.446	3.767
    0.721	1.088	1.422	1.715	2.182	2.666	3.453	3.786
    0.862	1.3	1.665	1.963	2.413	2.875	3.627	3.924
    0.729	1.145	1.508	1.813	2.284	2.777	3.624	3.98
    0.948	1.381	1.734	2.017	2.444	2.882	3.633	3.945
    1.081	1.535	1.895	2.179	2.592	2.993	3.596	3.821
    0.938	1.367	1.722	2.003	2.405	2.78	3.406	3.712
    0.852	1.229	1.573	1.877	2.364	2.852	3.505	3.763
    0.71	1.05	1.374	1.67	2.162	2.681	3.439	3.707
    0.74	1.087	1.405	1.688	2.148	2.632	3.383	3.666
    1.132	1.499	1.799	2.046	2.426	2.809	3.412	3.664
    1.226	1.612	1.918	2.164	2.53	2.888	3.465	3.726
    1.506	1.863	2.139	2.361	2.697	3.04	3.578	3.782
    1.415	1.749	2.018	2.242	2.595	2.957	3.5	3.699
    1.182	1.497	1.777	2.019	2.411	2.825	3.479	3.728
    1.314	1.606	1.852	2.06	2.393	2.75	3.379	3.666
    1.141	1.395	1.638	1.86	2.23	2.623	3.203	3.41
    1.245	1.421	1.596	1.771	2.088	2.443	2.97	3.155
    1.137	1.364	1.568	1.749	2.05	2.382	2.923	3.13
    1.079	1.264	1.446	1.618	1.918	2.249	2.757	2.941
    1.124	1.34	1.546	1.736	2.052	2.381	2.846	3.007
    1.14	1.331	1.51	1.687	2.004	2.355	2.871	3.051
    0.952	1.135	1.309	1.471	1.752	2.074	2.615	2.823
    0.948	1.117	1.279	1.431	1.699	2.014	2.56	2.777
    0.87	1.064	1.246	1.411	1.688	1.999	2.55	2.787
    0.948	1.129	1.3	1.454	1.704	1.955	2.355	2.709
    0.997	1.157	1.302	1.432	1.659	1.928	2.456	2.705
    1.12	1.305	1.458	1.584	1.774	1.95	2.211	2.519
    1.399	1.624	1.779	1.886	2.011	2.097	2.293	2.552
    1.657	1.791	1.869	1.929	2.036	2.184	2.501	2.648
    1.548	1.693	1.765	1.807	1.865	1.96	2.314	2.579
    1.602	1.78	1.887	1.956	2.048	2.153	2.447	2.637
    1.689	1.809	1.902	1.981	2.112	2.252	2.466	2.545
    1.792	1.959	2.098	2.213	2.377	2.517	2.687	2.743
    1.936	2.14	2.302	2.429	2.604	2.752	2.929	2.988
    1.986	2.131	2.252	2.359	2.532	2.7	2.918	2.991
    2.156	2.32	2.449	2.554	2.71	2.848	3.019	3.076
    2.112	2.26	2.378	2.475	2.616	2.742	2.896	2.948
    2.093	2.186	2.268	2.34	2.45	2.547	2.666	2.705
    2.12	2.207	2.252	2.277	2.313	2.369	2.551	2.649
    2.178	2.243	2.294	2.339	2.415	2.495	2.611	2.652
    2.179	2.216	2.238	2.257	2.292	2.341	2.446	2.494
    2.405	2.449	2.463	2.469	2.475	2.489	2.525	2.541
    2.467	2.502	2.528	2.551	2.586	2.619	2.659	2.673
    2.373	2.38	2.402	2.434	2.495	2.556	2.633	2.659
    2.411	2.419	2.461	2.515	2.611	2.702	2.815	2.853
    2.498	2.539	2.597	2.652	2.733	2.801	2.882	2.909
    2.782	2.831	2.88	2.923	2.983	3.032	3.089	3.108
    2.905	2.921	2.952	2.996	3.088	3.194	3.341	3.392
    2.859	2.874	2.907	2.948	3.025	3.108	3.223	3.263
    2.495	2.503	2.615	2.733	2.907	3.049	3.218	3.274
    2.413	2.418	2.537	2.668	2.875	3.056	3.276	3.349
    2.536	2.531	2.589	2.665	2.816	2.987	3.242	3.332
    2.249	2.269	2.401	2.537	2.737	2.906	3.107	3.174
    2.43	2.495	2.646	2.781	2.965	3.111	3.282	3.339
    2.106	2.138	2.273	2.425	2.685	2.939	3.266	3.376
    2.13	2.2	2.396	2.583	2.846	3.059	3.31	3.394
    2	2.1	2.321	2.523	2.805	3.033	3.303	3.393
    2.107	2.32	2.588	2.793	3.047	3.242	3.47	3.546
    2.298	2.55	2.783	2.945	3.138	3.284	3.454	3.511
    2.502	2.752	2.935	3.052	3.188	3.29	3.41	3.45
    2.312	2.513	2.714	2.858	3.033	3.166	3.321	3.373
    2.408	2.324	2.4	2.522	2.74	2.942	3.188	3.271
    1.607	1.463	1.659	1.916	2.323	2.669	3.08	3.217
    1.522	1.565	1.778	2.013	2.4	2.764	3.222	3.376
    1.285	1.499	1.65	1.776	1.989	2.226	2.578	2.701
    0.691	1.012	1.303	1.541	1.872	2.148	2.479	2.589
    0.449	0.756	1.096	1.398	1.841	2.221	2.679	2.832
    0.52	0.795	1.116	1.404	1.821	2.174	2.595	2.736
    0.523	0.818	1.129	1.406	1.817	2.175	2.61	2.756
    0.45	0.76	1.101	1.4	1.832	2.196	2.633	2.779
    0.467	0.839	1.235	1.585	2.097	2.536	3.065	3.242
    0.509	0.858	1.221	1.547	2.039	2.478	3.016	3.196
    0.453	0.726	1.023	1.304	1.758	2.192	2.745	2.932
    0.466	0.698	0.962	1.225	1.673	2.124	2.72	2.923
    0.567	0.828	1.084	1.325	1.731	2.155	2.749	2.954
    0.616	0.89	1.146	1.38	1.777	2.207	2.766	2.855
    0.47	0.713	0.97	1.213	1.612	2.002	2.508	2.679
    0.468	0.72	0.991	1.239	1.623	1.972	2.404	2.549
    0.492	0.742	0.986	1.214	1.603	2.01	2.401	2.333
    0.376	0.604	0.842	1.073	1.484	1.931	2.345	2.207
    0.472	0.701	0.925	1.138	1.516	1.941	2.44	2.37
    0.478	0.697	0.908	1.108	1.46	1.865	2.392	2.381
    0.35	0.53	0.708	0.88	1.195	1.573	2.12	2.125
    0.347	0.525	0.702	0.87	1.169	1.509	1.951	1.983
    0.407	0.522	0.685	0.863	1.18	1.5	1.917	2.057]./100;

dY = diff(Y, 1);

mu = mean(dY,1);
theta = cov(dY,1);

[U,S,V] = svd(theta); % U*S*V' = theta. Here, U=V.

dY_decomposed = (dY - mu)*U;

var2 = (S(1,1) + S(2,2)) / trace(S);
% 0.94492
% sigma = cov(dY_decomposed);
% (sigma(1,1) + sigma(2,2)) / trace(sigma)

T = [2 3 4 5];
CF = [80 70 150 40];
y = Y(end,1:4);

partial_derivative = CF .* exp(-y.*T) .* T;

dY_recomposed = mu + dY_decomposed(:,1:2) * U(:,1:2)';

dVal_random = dY_recomposed(:,1:4) * partial_derivative';

sd = std(dVal_random);
% 2.030206