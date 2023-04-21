# Estrategias de despliegues basadas en rutas

https://docs.openshift.com/container-platform/4.12/applications/deployments/route-based-deployment-strategies.html


oc new-app josedom24/citas-backend:v1 --name=exe-a
 4974  oc new-app josedom24/citas-backend:v2 --name=exe-b
 4975  oc expose svc/exe-a
 4976  oc delete route exe-a
 4977  oc expose svc/exe-a --port=10000
 4978  oc get route
 4979  oc set route-backends exe-a exe-a=198 exe-b=2
 4980  oc set route-backends exe-a exe-a=90 exe-b=10
 4981  oc set route-backends exe-a --equal
 4982  oc edit route exe-a
 4983  oc set route-backends exe-a exe-a=40 --adjust
 4984  oc set route-backends exe-a exe-a=30 --adjust
 4985  oc set route-backends exe-a exe-a=20 --adjust
 4986  oc set route-backends exe-a exe-a=10 --adjust
 4987  oc set route-backends exe-a exe-a=0 --adjust
 4988  oc set route-backends exe-a exe-a=100 --adjust
 4989  oc set route-backends exe-a exe-a=200 --adjust
 4990  oc set route-backends exe-a exe-a=300 --adjust
 4991  oc set route-backends exe-a exe-a=256 --adjust
 4992  oc set route-backends exe-a
 4993  history



while true; do curl http://exe-a-josedom24-dev.apps.sandbox-m3.1530.p1.openshiftapps.com/version; done


## Modificación del objeto Route para servir otra aplicación

## Despliegue Blue/Green basado en rutas

