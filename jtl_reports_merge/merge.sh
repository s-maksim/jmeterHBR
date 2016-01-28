#! /bin/bash
echo "timeStamp,elapsed,label,responseCode,responseMessage,threadName,success,bytes,grpThreads,allThreads,Latency" > foo1
cat Loadosophia_1.jtl | grep -v timeStamp >> foo2
cat Loadosophia_2.jtl | grep -v timeStamp | sed 's/,[^,]*/,1000/'10 >> foo2
cat Loadosophia_3.jtl | grep -v timeStamp | sed 's/,[^,]*/,1000/'10 >> foo2
cat Loadosophia_4.jtl | grep -v timeStamp | sed 's/,[^,]*/,1000/'10 >> foo2

cat foo2 | sort -k1 >> foo1
mv foo1 Merged_Results.jtl
gzip -9 Merged_Results.jtl
curl -v https://loadosophia.org/api/file/upload/ -F "token=`cat loadosophia_token.txt`" -F "projectKey=HBR_Perftest" -F "jtl_file=@Merged_Results.jtl.gz"
rm foo2
rm Loadosophia_*
rm Merged_Results.jtl.gz
