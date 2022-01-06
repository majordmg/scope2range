provided="$1" # provided scope 


# remove white spaces 
cat $provided | sed 's/ //g' > "./nospaces.txt"
provided="nospaces.txt"

# get unique third octet subnets 
oarr=$( cat ./provided.txt | sed "s/ //g" | cut -d "." -f 1,2,3 | sort -u )

for base in $oarr; do 
  ips_in_base=$(cat $provided | grep $base | sort -u)
  sorted=$(echo $ips_in_base | sed "s/ /\n/g" | cut -d "." -f 4 | sort -n)
  min=$(echo $sorted | cut -d " " -f 1)
  max=$(echo $sorted | rev | cut -d " " -f 1 | rev)
  subnet="$base.$min-$max"
  echo $subnet
done

