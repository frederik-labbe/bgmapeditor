#######################################################
package RecentsList;
#######################################################

use strict;

sub push_front {
	my ($file, $recentsfile, $recentslimit) = @_;
	
	my @recents = load($recentsfile);
	
	# remove other occurences of the file if any
	@recents = grep { $_ ne $file } @recents;
	
	# push file to front
	unshift(@recents, $file);
	
	# honor the limit
	if (@recents > $recentslimit) {
		@recents = @recents[0..$recentslimit-1];
	}
	
	#write to file
	@recents = join("\n", @recents);
	
	open(WH, '>', $recentsfile);
	print WH @recents;
	close(WH);
}

sub load {
	my $recentsfile = shift;
	
	if (!open(FH, $recentsfile)) {
		return ();
	}
	
	my @recents = <FH>;
	chomp @recents;
	close(FH);
	
	return @recents;
}


1;
