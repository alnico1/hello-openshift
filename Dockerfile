# ใช้ Node.js base image ที่มีขนาดเล็ก
FROM node:18-alpine

# ติดตั้ง Bash (สำหรับ Jenkins pipeline ที่ใช้ `sh`)
RUN apk add --no-cache bash

# สร้าง directory และตั้งเป็น working dir
WORKDIR /app

# คัดลอกไฟล์ทั้งหมดเข้าไปใน container
COPY . .

# ติดตั้ง dependency
RUN npm install

# เปิดพอร์ต 8080
EXPOSE 8080

# คำสั่งเริ่มต้นเมื่อ container เริ่มทำงาน
CMD ["npm", "start"]
