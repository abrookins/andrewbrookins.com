---
id: 290
title: CiviCRM Views 2 integration with a remote CiviCRM database
date: 2009-11-13T10:14:29+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=290
permalink: /tech/civicrm-views-2-integration-remote-civicrm-database/
aktt_notify_twitter:
  - 'no'
categories:
  - Technology
exclude_from_homepage: true
---
**Note:** This is an outdated, unmaintained, archived post. Proceed with caution.

The Views integration module released with CiviCRM as of version 2.2.8 works best if your CiviCRM and Drupal databases reside on the same server and are accessible by the same username and password. However, there are cases when this will not be so:

  * Your CiviCRM and Drupal databases are on different servers
  * CiviCRM resides in an external database from Drupal and you prefer (or are required) to use separate usernames and passwords

In these cases and others, there are two additional steps required to get Views integration working. The first is to add a `$db_url` entry in Drupal&#8217;s settings.php file. The second is to reference that URL in CiviCRM&#8217;s Views integration module.

**Note:** Before taking these steps, make sure you have also changed the `$db_prefix` variable. Instructions here:

[http://andrewbrookins.com/content/problems-and-solutions-problems-views-2-civi&#8230;](http://andrewbrookins.com/content/problems-and-solutions-problems-views-2-civicrm-and-drupal-6 "http://andrewbrookins.com/content/problems-and-solutions-problems-views-2-civicrm-and-drupal-6")

And here:

[http://wiki.civicrm.org/confluence/display/CRMDOC/Views2 Integration Module](http://wiki.civicrm.org/confluence/display/CRMDOC/Views2%20Integration%20Module "http://wiki.civicrm.org/confluence/display/CRMDOC/Views2 Integration Module")

### Step 1: Add a $db_url entry

Normally, your `settings.php` file will contain a line like this:

<pre>$db_url = 'mysqli://drupal_username:drupal_password@drupal_host/drupal_database';
</pre>

But if your CiviCRM database is on another server or accessed with a different username and password, Views needs the username, password and, if necessary, the host, to access it. So, change the `$db_url` variable to the following (with your username, password and host):

<pre>$db_url['default'] = 'mysqli://drupal_username:drupal_password@drupal_host/drupal_database';

$db_url['civicrm'] = 'mysqli://civicrm_user:civicrm_pass@civicrm_host/civicrm_database';
</pre>

**Note:**The entry for your Drupal database should always use the &#8216;default&#8217; key, as shown in my example.

Next, you will modify the Views integration module&#8217;s table definitions to point to this database URL when looking up CiviCRM data.

### Step 2: Point the CiviCRM Views integration module to the CiviCRM database

CiviCRM 2.2.8&#8217;s Views integration code appears to assume that the CiviCRM database is accessible by Drupal (IE, with the username and password associated with the Drupal database, and on the same host). In this step you will change that assumption.

Once you&#8217;ve added an entry in `$db_url`, the &#8216;civicrm&#8217; database URL is available in CiviCRM&#8217;s Views integration code. Next, modify the Views integration code to ask our &#8216;civicrm&#8217; host for the data. This is done on a table-by-table basis &#8212; yay!

The relevant code is in the following file:

`<br />
civicrm/drupal/modules/views/civicrm.views.inc`

Open that file up and find the following array definition:

<pre>$data['civicrm_contact']['table']['base'] = array(
    'field' => 'id', // Governs the whole mozilla
    'title' => t('CiviCRM Contacts'),
    'help' => t("View displays CiviCRM Contacts, of people, organizations, etc."),
);
</pre>

This is one of the arrays that Views uses to access the `civicrm_contact` table. You can see, looking at the rest of the code, that there is more involved; but this is the array you need to change.

Now, add the following key/value pair to the array:

<pre>'database' => 'civicrm',
</pre>

The final result should be:

<pre>$data['civicrm_contact']['table']['base'] = array(
    'field' => 'id', // Governs the whole mozilla
    'title' => t('CiviCRM Contacts'),
    'help' => t("View displays CiviCRM Contacts, of people, organizations, etc."),
    'database' => 'civicrm',
);
</pre>

To get it working with the rest of your data, search for the other `$data['table_name']['table']['base']` array definitions in `civicrm.views.inc` and add the same key/value pair to them.

Then create a view accessing CiviCRM data. Voila &#8212; it should work.

**Note:** If you already created a view (and were getting zero results back, no doubt!), then you need to **clear the views cache**.

References:

[http://drupal.org/node/235062](http://drupal.org/node/235062 "http://drupal.org/node/235062")
  
[http://groups.drupal.org/node/17638#comments](http://groups.drupal.org/node/17638#comments "http://groups.drupal.org/node/17638#comments")
