# chef-challenge
This is the response to a Chef Skills Assessment challenge.

## The Challenge

Our projects require a strong working skillset with Chef. I thought it would be fun to write some Chef code to see where you are in this craft.
Please complete the following tasks against this image ([link](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-2012-r2)):

- Install latest Microsoft patches

- install IIS

- open firewall port tcp/80

- create a site 'icons' on port 80

- host this content:
https://github.com/colebemis/feather.git

Please use one recipe for the patches and another recipe for the installation of IIS. Please store the code in a github repo and send me a link. Grant me access to read that repo and we can work on it together.

## Notes

- This project is using Git submodules for the dependency cookbooks. To checkout all of the cookbooks use:

```bash
git clone --recursive https://github.com/acrogecko/chef-challenge
```

- The Chef run_list starts with the `challenge_role` cookbook, `default` recipe, as in `'recipe[challenge_role::default]'` or just `'recipe[challenge_role]'`
