# Download the files
# cat Appfile | xargs -n1 curl -z -O

# Unzip any zipped files
unzip -o "*.zip"

# Move any basic .app files we have so far
# This will warn if the folders already exist and not do anything
for i in *.app ; do mv "$i" "/Applications/$i" ; done

# Loop through any dmg's
# Mount
original_path=`pwd`
for i in *.dmg
do
  dmg_path=`hdiutil mount $i | tail -1 | awk '{ print $3; }'`
  cd $dmg_path
  for k in *.app ; do cp -R "$k" "/Applications/$k" ; done
  for j in *.pkg ; do sudo installer -package $j -target "/Volumes/Macintosh HD" ; done
  cd $original_path

  # Unmount DMG
  hdiutil unmount "$dmg_path"
done
