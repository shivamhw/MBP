function rsync_copy {
	SOURCE_DIR=$(echo ~/$1)
	#read -p "Enter Target Location " TARGET_DIR
	TARGET_DIR=$2/$1_$(date +%b-%y)
	if [[ -d $TARGET_DIR ]]
	then
		echo $TARGET_DIR Exists! OverWrite ? 
		read choise
		case $choise in
			y|Y|yes|YES)
				echo Starting COPY....
				start_cp "$SOURCE_DIR" "$TARGET_DIR"
				;;
			*)
				echo OKAY BAYYEE
				exit 0
		esac
	else
		mkdir $TARGET_DIR
		echo $TARGET_DIR Created
		start_cp "$SOURCE_DIR" "$TARGET_DIR"
	fi

}

function start_cp {
	echo start_cp
	exit 0
}
