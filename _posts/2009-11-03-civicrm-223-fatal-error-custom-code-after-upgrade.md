---
id: 279
title: 'CiviCRM 2.2.3: Fatal error in custom code after upgrade'
date: 2009-11-03T10:05:10+00:00
author: Andrew
layout: post
guid: http://andrewbrookins.com/?p=279
permalink: /tech/civicrm-223-fatal-error-custom-code-after-upgrade/
categories:
  - Technology
---
The upgrade to CiviCRM 2.2.3 changed the sequence of data returned by the `civicrm_contact_get()` function in api/v2/Contact.php. If you&#8217;ve written any code against the CiviCRM API that uses this function, then 2.2.3 will probably break it.

Errors will likely show up anywhere that you depend on the array returned by civicrm\_contact\_get(). You will need to rewrite these to walk through an additional level of the array, per this forum post:

[http://forum.civicrm.org/index.php/topic,7884.0.html](http://forum.civicrm.org/index.php/topic,7884.0.html "http://forum.civicrm.org/index.php/topic,7884.0.html")

Or pass a boolean parameter to the function to get the deprecated array structure:</p> 

<div class="syntaxhighlighter nogutter  php" id="highlighter_735232">
  <div class="bar   ">
    <div class="toolbar">
      <a class="item viewSource" style="width: 16px; height: 16px;" title="view source" href="#viewSource">view source</a><a class="item printSource" style="width: 16px; height: 16px;" title="print" href="#printSource">print</a><a class="item about" style="width: 16px; height: 16px;" title="?" href="#about">?</a>
    </div>
  </div>
  
  <div class="lines">
    <div class="line alt1">
      <table>
        <tr>
          <td class="content">
            <code class="php variable">$contact</code> <code class="php plain">= civicrm_contact_get(</code><code class="php variable">$params</code><code class="php plain">, true);</code>
          </td>
        </tr>
      </table>
    </div>
  </div>
</div>

But obviously &#8212; using the old structure may not be a good idea. 

More info here:

[http://forum.civicrm.org/index.php/topic,8171.0.html](http://forum.civicrm.org/index.php/topic,8171.0.html "http://forum.civicrm.org/index.php/topic,8171.0.html")

[http://www.ubercart.org/issue/11131/doesnt\_work\_223](http://www.ubercart.org/issue/11131/doesnt_work_223 "http://www.ubercart.org/issue/11131/doesnt_work_223")