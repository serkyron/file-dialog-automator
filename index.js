const { execFile } = require('child_process');
const os = require('os');

module.exports.openFile = function(fullPath) {
    return new Promise((resolve, reject) => {
        if (!fullPath) {
            reject(new Error("Invalid path"));
            return;
        }

        let script = `${__dirname}/open.sh`;

        if (os.platform() === "win32") {
            script = `${__dirname}\\open.exe`;
        }

        execFile(script, [fullPath], {windowsHide: true}, (error, stdout, stderr) => {
            if (error) {
                reject(error);
                return;
            }

            resolve();
        });
    });
};
