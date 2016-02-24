#! /bin/bash
tail  /var/lib/jenkins/jobs/test_job_distributed/workspace/jmeter.log -n 50| grep -oE "/tmp/Loadosophia_[0-9]{1,100}"| sort -u| xargs -I{} cp "{}.jtl.gz" .; gunzip   Loadosophia_*
echo "timeStamp,elapsed,label,responseCode,responseMessage,threadName,success,bytes,grpThreads,allThreads,Latency" > foo1
ls Loadosophia_*|xargs -I{} cat "{}"| grep -v timeStamp | sed 's/,[^,]*/,1000/'10 >> foo2;
cat foo2 | sort -k1 >> foo1
mv foo1 Merged_Results.jtl
gzip -9 Merged_Results.jtl
curl -v https://loadosophia.org/api/file/upload/ -F "token=`cat loadosophia_token.txt`" -F "projectKey=HBR_Perftest" -F "jtl_file=@Merged_Results.jtl.gz"
rm foo2
rm Loadosophia_*
rm Merged_Results.jtl.gz
