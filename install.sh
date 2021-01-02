data_backups_dir="$HOME/.local/share/erate"
dollar_price_file="$data_backups_dir/dollar.txt"
euro_price_file="$data_backups_dir/euro.txt"
btc_price_file="$data_backups_dir/btc.txt"

declare -A osInfo;
osInfo[/etc/debian_version]="sudo apt-get install -y"
osInfo[/etc/alpine-release]="sudo apk --update add"
osInfo[/etc/centos-release]="sudo yum install -y"
osInfo[/etc/fedora-release]="sudo dnf install -y"
osInfo[/etc/manjaro-release]="sudo pamac install -y"

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        package_manager=${osInfo[$f]}
    fi  
done

curl_inst=0
[ $(curl --version | grep -Eci 'release-date') = 0 ] && curl_inst=1

if [ $curl_inst = 1 ]; then
    if [ -z $package_manager ]; then
        echo "unknown linux distro".
        echo "try installing jq with your package manager"
        echo "then run the installation command again"
        echo "exiting."
        exit
    fi
    [ curl_intst = 1 ] && $package_manager jq
fi


rm -rf $data_backups_dir
mkdir -p $data_backups_dir
touch $dollar_price_file $euro_price_file $btc_price_file

erate_script=$(wget -q -O- https://raw.githubusercontent.com/mhbahmani/erate/master/erate)

main_script_file=/usr/local/bin/erate
sudo rm -rf $main_script_file

sudo tee $main_script_file << EOF > /dev/null
$erate_script 
EOF

sudo chmod +x $main_script_file

echo ""Done!""
