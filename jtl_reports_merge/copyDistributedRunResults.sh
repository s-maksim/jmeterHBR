#! /bin/bash
tail  /var/lib/jenkins/jobs/test_job_distributed/workspace/jmeter.log -n 50| grep -oE "/tmp/Loadosophia_[0-9]{1,100}"| sort -u| xargs -I{} cp "{}.jtl.gz" .; gunzip   Loadosophia_*
