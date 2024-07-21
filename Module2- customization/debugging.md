## Debugging
### Terraform lets you see extra information about what it's doing. You can turn this on by setting a special option (TF_LOG) to any word. 
There are different levels of detail you can choose from (TRACE, DEBUG, INFO, WARN, ERROR) depending on how much information you want to see.

```sh
export TF_LOG_PATH=/tmp/crash.log
export TF_LOG=TRACE
```
