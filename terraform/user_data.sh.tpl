#!/bin/bash
echo "--------------------Start----------------------------"
sudo apt update -y
sudo apt install nginx -y
MYIP=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
cat <<EOF > /var/www/html/index.html
<html>
<head>
	<title>Main page</title>
</head>
<body>
<center><h1>DOS-07</h1></center>
Example index.html
<br/><br/>
<center><img alt="Dev_img" 
src="https://image.shutterstock.com/z/stock-photo-devops-methodology-development-operations-agil-programming-technology-concept-1914727306.jpg">
</center>
<br/><br/>
<font style="color:blue">Blue text</font>
<br/><br/>
<hr>
Url:
<a href=http://dos07.com/>
http://dos07.com/</a>
<br/><br/>
End
</body>
</html>
EOF

sudo systemctl start nginx
echo "--------------------Stop----------------------------"