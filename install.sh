data_backups_dir="$HOME/.local/share/erate"
dollar_price_file="$data_backups_dir/dollar.txt"
euro_price_file="$data_backups_dir/euro.txt"
btc_price_file="$data_backups_dir/btc.txt"

sudo apt install jq

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

