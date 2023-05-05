#!bin/bash

# - Check all variables
# - Add an option append and not delete the entire config
# - Add some checking
# - Add some option host template (Port etc ... )
# - Grab some more info from hostfile (Port, differente user different SSH KEY, )
# User can change output config
# User can say no to replace actual config

HOSTFILE=$1
USER=$2
SSHKEY=$3
ENV=$4

output="config"

if [[ -f $output ]]; then
	rm $output
fi

if [[ -f $HOSTFILE ]]; then
	echo "Hostfile exist"

	if [[ -n $USER ]]; then

		test="$(cat $HOSTFILE | awk '/^\[/ && !/vars/' | sed -r 's/\[//g' | sed -r 's/\]//g;')"
		test_lines="$(echo ${test} | wc -w | tr -d '[:space:]')"

		# for (( i = 1; i <= $test_lines; i++ )); do
		for (( i = 1; i <= test_lines; i++ )); do
			word="$(echo $test | awk "{print \$${i}}")"
			# echo "word: $word"
			HOSTSS="$(sed -n "/$word/,/^$/p" $HOSTFILE | tail -n +2 | grep -o '[0-9]\{0,3\}\.[0-9]\{0,3\}\.[0-9]\{0,3\}\.[0-9]\{0,3\}' | grep -Ev '^10\.')"
			countH="$(echo  $HOSTSS |  wc -w)"

			for (( j = 1; j <= countH; j++ )); do
				word2="$(echo $HOSTSS | awk "{print \$${j}}")"

				echo "IP $word$j : $word2 ADDED BIIIIITCH!!!"
				echo "Host $word$j-$ENV" >> $output
		    echo "  HostName $word2" >> $output
		    echo "  User ubuntu" >> $output
		    echo "  IdentityFile  $SSHKEY" >> $output
		    echo "  IdentitiesOnly yes" >> $output
				echo ' ' >> $output
			done
		done
		sudo cp -r $output ~/.ssh/$output
	else
		echo "User not set"
	fi
else
	echo "Please provide an Hostfile"
fi
