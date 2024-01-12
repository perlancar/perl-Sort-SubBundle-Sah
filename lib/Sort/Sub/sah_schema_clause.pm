package Sort::Sub::sah_schema_clause;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return {
        v => 1,
        summary => 'Sort Sah schema clause (and attributes)',
    };
}

sub gen_sorter {
    require Sort::BySpec;

    my ($is_reverse, $is_ci) = @_;

    Sort::BySpec::cmp_by_spec(
        spec => [
            # from defhash
            'v',

            # from defhash
            'defhash_v',

            'schema_v',

            'base_v',

            # from defhash
            'default_lang',

            # from defhash
            'name',
            qr/\Aname\./,

            # from defhash
            'caption',
            qr/\Acaption\./,

            # from defhash
            'summary',
            qr/\Asummary\./,

            # from defhash
            'description',
            qr/\Adescription\./,

            # from defhash
            'tags',

            'c',
            qr/\Ac\./ => sub { $_[0] cmp $_[1] },



            ## begin normal priority clauses

            # base type
            qr/\A(!)?ok([&|=])?\z/,
            qr/\A(!)?default([&|=])?\z/,
            qr/\A(!)?req([&|=])?\z/,
            qr/\A(!)?forbidden([&|=])?\z/,
            qr/\A(!)?prefilters([&|=])?\z/,
            qr/\A(!)?clause([&|=])?\z/,
            qr/\A(!)?clset([&|=])?\z/,
            qr/\A(!)?check([&|=])?\z/,
            qr/\A(!)?prop([&|=])?\z/,
            qr/\A(!)?check_prop([&|=])?\z/,
            qr/\A(!)?if([&|=])?\z/,

            # comparable
            qr/\A(!)?in([&|=])?\z/,
            qr/\A(!)?is([&|=])?\z/,

            # haselems
            qr/\A(!)?max_len([&|=])?\z/,
            qr/\A(!)?min_len([&|=])?\z/,
            qr/\A(!)?len_between([&|=])?\z/,
            qr/\A(!)?len([&|=])?\z/,
            qr/\A(!)?has([&|=])?\z/,
            qr/\A(!)?uniq([&|=])?\z/,
            qr/\A(!)?each_elem([&|=])?\z/,
            qr/\A(!)?check_each_elem([&|=])?\z/,
            qr/\A(!)?each_index([&|=])?\z/,
            qr/\A(!)?check_eaach_index([&|=])?\z/,
            qr/\A(!)?exists([&|=])?\z/,
            qr/\A(!)?check_exists([&|=])?\z/,

            # sortable
            qr/\A(!)?min([&|=])?\z/,
            qr/\A(!)?xmin([&|=])?\z/,
            qr/\A(!)?max([&|=])?\z/,
            qr/\A(!)?xmax([&|=])?\z/,
            qr/\A(!)?between([&|=])?\z/,
            qr/\A(!)?xbetween([&|=])?\z/,

            # float
            qr/\A(!)?is_nan([&|=])?\z/,
            qr/\A(!)?is_inf([&|=])?\z/,
            qr/\A(!)?is_pos_inf_len([&|=])?\z/,
            qr/\A(!)?is_neg_inf([&|=])?\z/,

            # int
            qr/\A(!)?mod([&|=])?\z/,
            qr/\A(!)?div_by([&|=])?\z/,

            # str
            qr/\A(!)?encoding([&|=])?\z/,
            qr/\A(!)?match([&|=])?\z/,
            qr/\A(!)?is_re([&|=])?\z/,

            # bool
            qr/\A(!)?is_true([&|=])?\z/,

            # array
            qr/\A(!)?elems([&|=])?\z/,
            qr/\A(!)?of([&|=])?\z/, # as well as for 'any', 'all' types

            # hash
            qr/\A(!)?keys([&|=])?\z/,
            qr/\A(!)?re_keys([&|=])?\z/,
            qr/\A(!)?req_keys([&|=])?\z/,
            qr/\A(!)?allowed_keys([&|=])?\z/,
            qr/\A(!)?allowed_keys_re([&|=])?\z/,
            qr/\A(!)?forbidden_keys([&|=])?\z/,
            qr/\A(!)?forbidden_keys_re([&|=])?\z/,
            qr/\A(!)?each_key([&|=])?\z/,
            qr/\A(!)?each_value([&|=])?\z/,
            qr/\A(!)?check_each_key([&|=])?\z/,
            qr/\A(!)?check_each_value([&|=])?\z/,
            qr/\A(!)?choose_one_key([&|=])?\z/,
            qr/\A(!)?choose_one([&|=])?\z/,
            qr/\A(!)?choose_all_keys([&|=])?\z/,
            qr/\A(!)?choose_all([&|=])?\z/,
            qr/\A(!)?choose_some_keys([&|=])?\z/,
            qr/\A(!)?choose_some([&|=])?\z/,
            qr/\A(!)?req_one_key([&|=])?\z/,
            qr/\A(!)?req_one([&|=])?\z/,
            qr/\A(!)?req_all_keys([&|=])?\z/,
            qr/\A(!)?req_all([&|=])?\z/,
            qr/\A(!)?req_some_keys([&|=])?\z/,
            qr/\A(!)?req_some([&|=])?\z/,
            qr/\A(!)?dep_any([&|=])?\z/,
            qr/\A(!)?dep_all([&|=])?\z/,
            qr/\A(!)?req_dep_any([&|=])?\z/,
            qr/\A(!)?req_dep_all([&|=])?\z/,

            # obj
            qr/\A(!)?can([&|=])?\z/,
            qr/\A(!)?isa([&|=])?\z/,

            # end normal priority clauses



            ### begin low priority clauses

            # base type
            qr/\A(!)?postfilters([&|=])?\z/,
            qr/\A(!)?examples([&|=])?\z/,
            qr/\A(!)?invalid_examples([&|=])?\z/,

            ### end low priority clauses

            'x',
            qr/\Ax\./ => sub { $_[0] cmp $_[1] },

            #
            qr// => sub {
                my ($normalized_a, $normalized_b) = @_;
                for ($normalized_a, $normalized_b) {
                    s/\A!|[&|=]\z//;
                }
                $normalized_a cmp $normalized_b || $_[0] cmp $_[1];
            },
        ],
        reverse => $is_reverse,
    );
}

1;
# ABSTRACT:

=for Pod::Coverage ^(gen_sorter|meta)$

=cut
