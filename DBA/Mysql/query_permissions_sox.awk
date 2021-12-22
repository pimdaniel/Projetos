BEGIN {  FS="\t"
         OFS=";"
      }
{
   print $1,$2,$3
}
