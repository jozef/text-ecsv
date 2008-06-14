use Test::More;
use Test::Spelling;

add_stopwords(qw(
	Jozef
));
all_pod_files_spelling_ok();
