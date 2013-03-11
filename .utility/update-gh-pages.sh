echo -e "Starting to update gh-pages\n"

git fetch -n origin
git checkout -b gh-pages origin/gh-pages

cp -rf coverage/* .

git remote set-url origin https://${GH_TOKEN}@github.com/Uko/Rubidium-WHOIS.git > /dev/null
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis"
git add -f .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
git push -fq origin gh-pages > /dev/null

echo -e "Done magic with coverage\n"
