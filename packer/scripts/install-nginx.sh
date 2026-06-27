#!/bin/bash
set -euo pipefail

dnf update -y
dnf install -y nginx

cat > /usr/share/nginx/html/index.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>HW9 Packer AMI</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      min-height: 100vh;
      display: grid;
      place-items: center;
      background: #f6f8fb;
      color: #172033;
    }

    main {
      max-width: 720px;
      padding: 40px;
      border: 1px solid #d7dee9;
      background: #ffffff;
    }

    h1 {
      margin-top: 0;
    }
  </style>
</head>
<body>
  <main>
    <h1>HW9 Packer AMI</h1>
    <p>Nginx was installed during the AMI build.</p>
  </main>
</body>
</html>
HTML

systemctl enable nginx
systemctl start nginx
