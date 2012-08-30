packages='util-linux gawk grep gzip tar inetutils freetype2 ca-certificates-java libxrender libxt libxtst nss xdg-utils hicolor-icon-theme libjpeg-turbo libpng icedtea-web'


if [ -d jail ]; then
    umount jail/dev/pts
    umount jail/dev/shm
    umount jail/dev
    umount jail/._dev
    umount jail/proc
    umount jail/sys
    umount jail/run
    umount jail/tmp
    fusermount -u jail/mnt
    rm -r jail
fi
mkdir jail
cd jail


msg()
{   echo -e '\033[34;01m::\033[21;39m' "$@"
}


msg 'Making lib directories'
mkdir usr usr/lib usr/lib32 usr/libexec
ln -s usr/lib lib
ln -s usr/lib lib64


package()
{
    for pac in $@; do
	pac="$(echo "$pac" | sed -e 's/>/=/g' -e 's/</=/g' | sed -e 's/=.*//g')"
	if [ ! "$pac" = 'None' ] && [ ! -f _installed_/"$pac" ]; then
	    msg 'Cloning package' "$pac"
	    pacman -Ql "$pac" | sed -e 's/^'"$pac"' /'\''/g' | grep '/$' | sed -e 's/$/'\''/g' | sed -e 's/^/'"$(pwd | sed -e 's/\//\\\//g')"'/g' | xargs mkdir -p
	    pacman -Ql "$pac" | sed -e 's/^'"$pac"' /'\''/g' | grep -v '/$' | sed -e 's/$/'\''/g' | sed -E 's/^(.*)$/cp \1 '"'$(pwd | sed -e 's/\//\\\//g')'"'\1;/g' | sh
	    touch _installed_/"$pac"
	    
	    # currently this works for the used packages, but if the dependencies for any package because to many this may not work
	    package $(pacman -Si "$pac" | grep 'Depends On     : ' | sed -e 's/^Depends On     : //g')
	fi
    done
}

get()
{
    pacman -Qo "$1" | sed -e "s/$(echo "$1" | sed -e 's/\//\\\//g') is owned by //g" | cut -d ' ' -f 1
}


mkdir _installed_
shell=`get "$SHELL"`
package $shell $packages
rm -r _installed_


msg 'Making /root'
mkdir root
cd root
msg 'Making extracting files.tar.xz to /root'
tar --get --xz < ../../files.tar.xz
cd ..


msg 'Making /dev and /proc'
mkdir ._dev dev proc
mount -t devtmpfs dev ._dev
mount -t proc proc proc
for file in $(echo null urandom); do
    ln -s /._dev/$file dev/$file
done


msg 'Mounting maple15_64.iso'
mkdir mnt
fuseiso ../maple15_64.iso mnt


msg 'Running chroot in' "$(pwd)"

echo -en '\e[31;1m'
echo 'Execute ./mnt/install*'
echo -n 'You should change the install directory to /opt/maple15'
echo -e '\e[39;21m'

chroot $(pwd)


umount dev/pts
umount dev/shm
umount dev
umount ._dev
umount proc
umount sys
umount run
umount tmp
fusermount -u mnt


