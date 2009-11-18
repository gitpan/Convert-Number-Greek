BEGIN { require 5.008 }
use strict;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Convert::Number::Greek',
    AUTHOR              => 'Father Chrysostomos',
    VERSION_FROM        => 'lib/Convert/Number/Greek.pm',
    ABSTRACT_FROM       => 'lib/Convert/Number/Greek.pm',
    PL_FILES            => {},
    PREREQ_PM => {
	 Exporter => 0,
	 POSIX    => 0,
	 strict   => 0,
	 Test     => 0,
	 utf8     => 0,
	 warnings => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Convert-Number-Greek-*' },
);
