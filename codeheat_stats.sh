#!/bin/bash

set -e

here="`dirname \"$0\"`"

best_24_09_2017="susi_chromebot codeheat.org  susi_skill_data badgeyay pslab-android fossasia.org query-server open-event-android susi_skill_cms susper.com open-event-orga-server phimpme-android opentechsummit.cn susi_android loklak_wok_android chat.susi.ai open-event-orga-app open-event-frontend gci16.fossasia.org susi_server  2018.fossasia.org  loklak_search fossasia-nodemailer mew yaydoc"

for repository in $best_24_09_2017; do
  2>&1 "$here/activity.sh" "https://github.com/fossasia/$repository" | tee "${repository}.log" | tail -n 1
done
  



