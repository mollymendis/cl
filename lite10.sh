sudo apt update -y > /dev/null 2>&1
echo "Installing QEMU (2-3m)..."
sudo apt install qemu-system-x86 curl -y > /dev/null 2>&1
read -p "Link win: " CRM
echo Downloading Windows Disk...
curl -L -o lite10.qcow2 $CRM
echo "Download ngrok"
wget -O ngrok.tgz https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1
tar -xf ngrok.tgz > /dev/null 2>&1
rm -rf ngrok.tgz
read -p "Ctrl + V Authtoken: " CRP 
./ngrok authtoken $CRP 
clear
echo "choose ngrok region (for better connection)."
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "choose ngrok region: " CRP
./ngrok tcp --region $CRP 5900 &>/dev/null &
sleep 1
echo "Windows 10 x64 Lite On Google Colab"
echo Your VNC IP Address:
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "Note: Use Right-Click Or Ctrl+C To Copy"
echo "Please Keep Colab Tab Open, Maximum Time 12h"
sudo qemu-system-x86_64 -vnc :0 -hda lite10.qcow2  -smp cores=4  -m 8192M -net user -net nic -machine usb=on -device usb-tablet > /dev/null 2>&1
