parent_dir="$(cd ../ && pwd)"
cp $parent_dir/7694-088/7694_088.xml 7694-088.xml
cp $parent_dir/7694-087/7694_087.xml 7694-087.xml
cp $parent_dir/7694-086/7694_086.xml 7694-086.xml

field=()
touch data.js
data="data.js"
echo "var files_html = [" > $data;
for i in $(find *.xml); do
  field+=$i;
  xsltproc transform.xslt $i  > $(basename "$i" .xml).html;
  echo \"$(basename "$i" .xml).html\" >> $data;
  echo "," >> $data;
done
echo "]" >> $data;
