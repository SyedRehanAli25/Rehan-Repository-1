nano commands.sh
pwd
mkdir linux
mkdir linux/Assignment-01
mkdir /tmp/dir1
/tmp
 └── dir1
     ├── dir2
     └── dir3
mkdir -p /tmp/dir1/dir2 /tmp/dir1/dir3
rm -r /tmp/dir1/dir3
touch /tmp/john
echo "This is my first line" > /tmp/john
echo "this is a additional content" >> /tmp/john
echo "doe is my last name" > /tmp/doe
{ echo "this is line at the beginning"; cat /tmp/doe; } > /tmp/doe.tmp && mv /tmp/doe.tmp /tmp/doe
for i in {1..10}; do echo "This is line number $i" >> /tmp/doe; done
head -n 5 /tmp/doe
tail -n 2 /tmp/doe
awk 'NR>=3 && NR<=8' /tmp/doe
ls -la /tmp
find /tmp -maxdepth 1 -type f
find /tmp -maxdepth 1 -type d
cp /tmp/doe /tmp/dir1/dir2/
cp /tmp/doe /tmp/dir1/dir2/doe.copy
mv /tmp/john /tmp/john_new
mv /tmp/doe /tmp/dir1/
> /tmp/dir1/dir2/doe.copy
rm /tmp/dir1/dir2/doe.copy
