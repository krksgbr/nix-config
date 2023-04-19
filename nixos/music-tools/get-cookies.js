// This script exports bandcamp cookies for bandcamp-collection-downloader from
// https://github.com/Ezwen/bandcamp-collection-downloader

const { execSync } = require("child_process");

const exec = (cmd) => execSync(cmd, { encoding: "utf8" });

const nonEmptyString = (it) => !!it;

const cookies = exec(`fd "cookies" ~/.mozilla/firefox`)
  .split("\n")
  .filter(nonEmptyString)
  .map((db) => {
    try {
      return exec(
        `sqlite3 -json ${db}  "select * from moz_cookies where host = '.bandcamp.com'"`
      );
    } catch (e) {
      console.log(`Warning: ${e}`);
    }
  })
  .filter(nonEmptyString)
  .map(JSON.parse)
  .reduce((a, b) => a.concat(b), [])
  .filter((cookie) => {
    return Date.now() < cookie.expiry * 1000;
  })
  .map(({ name, value }) => ({ "Name raw": name, "Content raw": value }));

if (cookies.length > 0) {
  console.log(JSON.stringify(cookies));
} else {
  console.log(
    "Bandcamp cookies have expired. Please login with Firefox to refresh cookies."
  );
  process.exit(1);
}
