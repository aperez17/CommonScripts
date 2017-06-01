const vorpal = require('vorpal')();
const chalk = vorpal.chalk;
const exec = require('child_process').exec;
const args = process.argv;

runColorTail = function() {
    vorpal
        .command('ctail', "Runs catalina out with colors")
        .action(function(args, callback) {
            const self = this;
            const command = "ctail";
            exec(command, function(error, stdout, stderr) {
                self.log(stdout);
                self.log(stderr);
            });
        });
};

addReviewCommand = function() {
    vorpal
        .command('review', "Pulls, adds, and commits whatever from base directory")
        .action(function(args, callback) {
            const self = this;
            this.prompt({
                type: 'input',
                name: 'jira',
                message: 'Please enter your JIRA ticket: '
            }, function(result) {
                const jiraNum = result.jira;
                self.prompt({
                    type: 'input',
                    name: 'message',
                    message: 'Please enter a commit message: '
                }, function(r) {
                    const commitMsg = jiraNum + " " + r.message;
                    const command = "review \"" + commitMsg + "\"";
                    self.log("commiting: ");
                    self.log(commitMsg);
                    self.prompt({
                        type: 'input',
                        name: 'push',
                        message: 'Do you want to push as well? (n/y) '
                    }, function(r2) {
                      let command;
                      if (r2.push === 'y' || r2.push === 'yes') {
                          command = 'review ' + "\"" + commitMsg +"\"" + " true";
                      } else {
                          command = 'review ' + "\"" + commitMsg + "\"";
                      }
                      exec(command, function(error, stdout, stderr) {
                          self.log(stdout);
                          self.log(stderr);
                      });
                    });
                });
            });
        });
};

addCloudVersionCommand = function() {
    vorpal
        .command('cloud', "Changes the cloud version to the specified version")
        .action(function(args, callback) {
            const self = this;
            // self.prompt({
            //     type: 'input',
            //     name: 'mode',
            //     message: 'Enter v to edit the current version on cloud file or p to edit the path on a cloud file'
            // })
            self.prompt({
                type: 'input',
                name: 'cloudFile',
                message: "Please enter the cloud file you wish to edit"
            }, function (r) {
                const cloudFile = r.cloudFile;
                self.prompt({
                    type: 'input',
                    name: 'version',
                    message: "Please enter a new cloud version: "
                }, function(result) {
                    let command = "change_cloud_version " + result.version + " " + cloudFile;
                    exec(command, function(error, stdout, stderr) {
                        self.log(stdout);
                        self.log(stderr);
                    });
                });
            });
        });
};

addReviewCommand();
addCloudVersionCommand();
runColorTail();

vorpal
  .delimiter(chalk.magenta('dev_tools~$'))
  .parse(process.argv);
vorpal.show();
