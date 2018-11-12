# Run from repository root dir
if [ -f .git-add_copyright.sh ]
then
    ln -fs ../../.git-add_copyright.sh .git/hooks/pre-commit
else
    echo '\nError: Fix copyright script not found repository.'
fi