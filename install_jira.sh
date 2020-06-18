curl -s https://api.github.com/repos/go-jira/jira/releases/latest \
  | grep "browser_download_url.*jira-linux-amd64" \
  | cut -d : -f 2,3  | tr -d \" \
  | xargs -n1 curl -L > bin/jira \
  && chmod +x bin/jira
