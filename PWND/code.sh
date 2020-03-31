echo "struct group_info init_groups = { .usage = ATOMIC_INIT(2) };

struct group_info *groups_alloc(int gidsetsize){

        struct group_info *group_info;

        int nblocks;

        int i;"
sleep .5

echo "
        nblocks = (gidsetsize + NGROUPS_PER_BLOCK - 1) / NGROUPS_PER_BLOCK;

        /* Make sure we always allocate at least one indirect block pointer */

        nblocks = nblocks ? : 1;

        group_info = kmalloc(sizeof(*group_info) + nblocks*sizeof(gid_t *), GFP_USER);"
sleep .5
echo "if (!group_info)

                return NULL;

        group_info->ngroups = gidsetsize;

        group_info->nblocks = nblocks;

        atomic_set(&group_info->usage, 1);



        if (gidsetsize <= NGROUPS_SMALL)"
sleep .5
echo "if (!group_info)

                return NULL;

        group_info->ngroups = gidsetsize;

        group_info->nblocks = nblocks;

        atomic_set(&group_info->usage, 1);



        if (gidsetsize <= NGROUPS_SMALL)"
sleep .5
echo "out_undo_partial_alloc:

        while (--i >= 0) {

                free_page((unsigned long)group_info->blocks[i]);

        }

        kfree(group_info);

        return NULL;

}"
sleep .5
echo "EXPORT_SYMBOL(groups_alloc);



void groups_free(struct group_info *group_info)

{

        if (group_info->blocks[0] != group_info->small_block) {

                int i;

                for (i = 0; i < group_info->nblocks; i++)

                        free_page((unsigned long)group_info->blocks[i]);

        }

        kfree(group_info);

}"
sleep .5
echo "EXPORT_SYMBOL(groups_free);



/* export the group_info to a user-space array */

static int groups_to_user(gid_t __user *grouplist,

                          const struct group_info *group_info)"
sleep .5
echo "{

        int i;

        unsigned int count = group_info->ngroups;



        for (i = 0; i < group_info->nblocks; i++) {

                unsigned int cp_count = min(NGROUPS_PER_BLOCK, count);

                unsigned int len = cp_count * sizeof(*grouplist);



                if (copy_to_user(grouplist, group_info->blocks[i], len))

                        return -EFAULT;



                grouplist += NGROUPS_PER_BLOCK;

                count -= cp_count;

        }"
sleep .5
echo "/* fill a group_info from a user-space array - it must be allocated already */

static int groups_from_user(struct group_info *group_info,

    gid_t __user *grouplist)

{

        int i;

        unsigned int count = group_info->ngroups;



        for (i = 0; i < group_info->nblocks; i++) {

                unsigned int cp_count = min(NGROUPS_PER_BLOCK, count);

                unsigned int len = cp_count * sizeof(*grouplist);



                if (copy_from_user(group_info->blocks[i], grouplist, len))

                        return -EFAULT;
}"








echo "struct group_info init_groups = { .usage = ATOMIC_INIT(2) };

struct group_info *groups_alloc(int gidsetsize){

        struct group_info *group_info;

        int nblocks;

        int i;"


echo "
        nblocks = (gidsetsize + NGROUPS_PER_BLOCK - 1) / NGROUPS_PER_BLOCK;

        /* Make sure we always allocate at least one indirect block pointer */

        nblocks = nblocks ? : 1;

        group_info = kmalloc(sizeof(*group_info) + nblocks*sizeof(gid_t *), GFP_USER);"
sleep .5
echo "if (!group_info)

                return NULL;

        group_info->ngroups = gidsetsize;

        group_info->nblocks = nblocks;

        atomic_set(&group_info->usage, 1);



        if (gidsetsize <= NGROUPS_SMALL)"

echo "if (!group_info)

                return NULL;

        group_info->ngroups = gidsetsize;

        group_info->nblocks = nblocks;

        atomic_set(&group_info->usage, 1);



        if (gidsetsize <= NGROUPS_SMALL)"

echo "out_undo_partial_alloc:

        while (--i >= 0) {

                free_page((unsigned long)group_info->blocks[i]);

        }

        kfree(group_info);

        return NULL;

}"
sleep .5
echo "EXPORT_SYMBOL(groups_alloc);



void groups_free(struct group_info *group_info)

{

        if (group_info->blocks[0] != group_info->small_block) {

                int i;

                for (i = 0; i < group_info->nblocks; i++)

                        free_page((unsigned long)group_info->blocks[i]);

        }

        kfree(group_info);

}"

echo "EXPORT_SYMBOL(groups_free);



/* export the group_info to a user-space array */

static int groups_to_user(gid_t __user *grouplist,

                          const struct group_info *group_info)"

echo "{

        int i;

        unsigned int count = group_info->ngroups;



        for (i = 0; i < group_info->nblocks; i++) {

                unsigned int cp_count = min(NGROUPS_PER_BLOCK, count);

                unsigned int len = cp_count * sizeof(*grouplist);



                if (copy_to_user(grouplist, group_info->blocks[i], len))

                        return -EFAULT;



                grouplist += NGROUPS_PER_BLOCK;

                count -= cp_count;

        }"

echo "/* fill a group_info from a user-space array - it must be allocated already */

static int groups_from_user(struct group_info *group_info,

    gid_t __user *grouplist)

{

        int i;

        unsigned int count = group_info->ngroups;



        for (i = 0; i < group_info->nblocks; i++) {

                unsigned int cp_count = min(NGROUPS_PER_BLOCK, count);

                unsigned int len = cp_count * sizeof(*grouplist);



                if (copy_from_user(group_info->blocks[i], grouplist, len))

                        return -EFAULT;
}"
clear
