---
id: 282
title: 'Problems and Solutions to Problems: Views 2, CiviCRM, and Drupal 6'
date: 2009-11-13T10:10:15+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=282
permalink: /tech/problems-and-solutions-problems-views-2-civicrm-and-drupal-6/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
---
The following is a quick run-down of problems you might run into using Views 2 integration with CiviCRM 2.2.3 and Drupal 6 (or higher):

**Update (11/20/2011):** This is an outdated, unmaintained post. Proceed with caution.

**Update (12/24/09):** I recently added a new issue to this list, after updating a site to Drupal 6.15: CCK fields won&#8217;t save and/or you get &#8220;Table &#8216;batch&#8217; already exists&#8221; errors. See below (number 3).

### 1. When creating a view of CiviCRM data using the Views user interface, no data is returned.

Running the query that Views generated directly against the database returns a result, but Views comes back empty.  If you haven&#8217;t used Views 2 to access a database external to your Drupal database before, then this one might be a stumper.

Never fear!  The fix is easy.  You probably need to update the `$db_prefix` variable in your Drupal `settings.php` file. As outlined in the CiviCRM docs ([http://wiki.civicrm.org/confluence/display/CRMDOC/Views2 Integration Module](http://wiki.civicrm.org/confluence/display/CRMDOC/Views2%20Integration%20Module "http://wiki.civicrm.org/confluence/display/CRMDOC/Views2 Integration Module")), you need to change this line:

<pre>$db_prefix = '';</pre>

To an array that includesallof the CiviCRM tables, including your custom tables:

<pre>$db_prefix = array(
 'default' =&gt; '',
 'civicrm_acl' =&gt; 'civicrm.',
 'civicrm_acl_cache' =&gt; 'civicrm.',
 'civicrm_acl_entity_role' =&gt; 'civicrm.',
 'civicrm_activity' =&gt; 'civicrm.',
 'civicrm_activity_assignment' =&gt; 'civicrm.',
 'civicrm_activity_target' =&gt; 'civicrm.',
 'civicrm_address' =&gt; 'civicrm.',
 'civicrm_cache' =&gt; 'civicrm.',
 'civicrm_case' =&gt; 'civicrm.',
 'civicrm_case_activity' =&gt; 'civicrm.',
 'civicrm_case_contact' =&gt; 'civicrm.',
 'civicrm_component' =&gt; 'civicrm.',
 'civicrm_contact' =&gt; 'civicrm.',
 'civicrm_contact_ar_EG' =&gt; 'civicrm.',
 'civicrm_contact_en_US' =&gt; 'civicrm.',
 'civicrm_contact_ru_RU' =&gt; 'civicrm.',
 'civicrm_contribution' =&gt; 'civicrm.',
 'civicrm_contribution_page' =&gt; 'civicrm.',
 'civicrm_contribution_page_ar_EG' =&gt; 'civicrm.',
 'civicrm_contribution_page_en_US' =&gt; 'civicrm.',
 'civicrm_contribution_page_ru_RU' =&gt; 'civicrm.',
  //  more tables .... 
);</pre>

**Note:** I used to set the &#8216;default&#8217; array element to &#8216;drupal.&#8217; but this appears to cause problems. I now use an empty string for the &#8216;default&#8217; element, but if an empty string isn&#8217;t working for you, try &#8216;drupal.&#8217; for that element.

Also: I only listed some of the tables in the above example. Check the CiviCRM demo site for a comprehensive listing that includes a few custom table examples: [http://drupal.demo.civicrm.org/civicrm/admin/setting/uf?reset=1](http://drupal.demo.civicrm.org/civicrm/admin/setting/uf?reset=1 "http://drupal.demo.civicrm.org/civicrm/admin/setting/uf?reset=1")

You can also use that URL to check the current settings on your installation (e.g., http://your.site.org/civicrm/admin/setting/uf?reset=1).

### 2. You get SQL errors when trying to use custom fields in a view

At this point, you have Views integration working. Then you try to sort or return data from a custom field, and Views spits out something like the following:

<pre>user warning: Table 'drupal.civicrm_value_custom_field_2' doesn't exist query:
SELECT civicrm_event.id AS id, civicrm_event.start_date AS civicrm_event_start_date,
civicrm_value_custom_table_2.custom_value_4 AS civicrm_value_custom_table_2_custom_value_4
FROM xxxxx_civicrm.civicrm_event civicrm_event
LEFT JOIN civicrm_value_custom_table_2 civicrm_value_custom_table_2
ON civicrm_event.id = civicrm_value_custom_table_2.entity_id
LIMIT 0, 10
in /usr/local/home/username/sites/your.site.org/modules/views/includes/view.inc on line 731.</pre>

This happens if you try to access a custom data group in Views whose table hasn&#8217;t been added to the `$db_prefix` array ([http://forum.civicrm.org/index.php/topic,8075.0.html](http://forum.civicrm.org/index.php/topic,8075.0.html "http://forum.civicrm.org/index.php/topic,8075.0.html")).

Any time you add a new group of custom fields to CiviCRM, you need to add the name of the table (CiviCRM stores custom data groups as tables in its database) to the `$db_prefix` array in Drupal&#8217;s settings.php file. Otherwise, Views won&#8217;t be able to find any of the fields in the group.

### 3. CCK Fields Won&#8217;t Save and/or &#8220;user warning: Table &#8216;batch&#8217; already exists&#8221; Errors

Wow, this one rocked my socks. I literally spent the past few days debugging this, and I wouldn&#8217;t have even known it was related to my $db_prefix variable if [David Machota](http://drupal.org/user/58057) hadn&#8217;t written to inform me he&#8217;d discovered a fix.

The problem: You can&#8217;t save CCK fields (I ran into this personally) or you keep getting a &#8220;user warning: Table &#8216;batch&#8217; already exists&#8221; error message ([David posted an entry on Drupal.org describing this one](http://drupal.org/node/662860#comment-2391510)).

The solution appears to be leaving the &#8216;default&#8217; $db_prefix array element blank when you declare your prefixes in settings.php. The example in this post had previously used &#8216;drupal.&#8217; as the default prefix, but this appears to cause problems (after Drupal 6.14 and possible before).

So, if you run into either of these problems, use an empty string for the &#8216;default&#8217; $db_prefix element. I have updated the examples in this post to do so. Also, please drop me an email if using an empty string like this fudges your system.