data_backups_dir="$HOME/.local/share/erate"
dollor_price_file="$data_backups_dir/dollor.txt"
euro_price_file="$data_backups_dir/euro.txt"

sudo mkdir $date_backup_dir
sudo touch $dollar_price_file
sudo touch $euro_price_file

sudo chmod 646 $dollar_price_file
sudo chmod 646 $euro_price_file

erate_scripts=$(wget -q -O- https://raw.githubusercontent.com/mhbahmani/erate/master/erate)

main_script_file=/usr/local/bin/erate
sudo rm -rf $main_script_file

sudo tee << EOF > $main_script_file
$erate_scripts
EOF

sudo chmod +x $main_script_file

