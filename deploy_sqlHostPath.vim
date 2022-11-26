apiVersion: v1
kind: Namespace
metadata:
  name: lab3
  labels:
    name: lab3
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: mysql
    owner: rutuj
  name: deploymysql
  namespace: lab3
spec:
  selector:
    matchLabels:
      app: mysql
  replicas: 1
  template:
    metadata:
      labels:
        app: mysql
    spec:
      volumes:
      - name: mysql-pvc-manual
        persistentVolumeClaim:
          claimName: mysql-pvc-manual
      containers:
      - name: mysql
        image: 899518646067.dkr.ecr.us-east-1.amazonaws.com/webapp-dev-mysql:v1.0
        volumeMounts:
          - mountPath: /data
            name: mysql-pvc-manual
        imagePullPolicy: "Always"
        ports:
        - name: mysql
          containerPort: 3306
          protocol: TCP
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: "pw"
      dnsPolicy: ClusterFirst
      restartPolicy: Always

