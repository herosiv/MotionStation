## Copyright (C) 2008 Soren Hauberg <soren@hauberg.org>a
##
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or (at
## your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; see the file COPYING.  If not, see
## <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} generate_package_html (@var{name}, @var{outdir}, @var{options})
## Generate @t{HTML} documentation for a package.
##
## The function reads information about package @var{name} using the
## package system. This is then used to generate bunch of
## @t{HTML} files; one for each function in the package, and one overview
## page. The files are all placed in the directory @var{outdir}, which defaults
## to the current directory. The @var{options} structure is used to control
## the design of the web pages.
##
## As an example, the following code generates the web pages for the @t{image}
## package, with a design suitable for the @t{Octave-Forge} project.
##
## @example
## options = get_html_options ("octave-forge");
## generate_package_html ("image", "image_html", options);
## @end example
##
## The resulting files will be available in the @t{"image_html"} directory. The
## overview page will be called @t{"image_html/overview.html"}.
##
## As a convenience, if @var{options} is a string, a structure will
## be generated by calling @code{get_html_options}. This means the above
## example can be reduced to the following.
##
## @example
## generate_package_html ("image", "image_html", "octave-forge");
## @end example
##
## It should be noted that the function only works for installed packages.
## @seealso{get_html_options}
## @end deftypefn

function generate_package_html (name = [], outdir = "htdocs", options = struct ())
  ## Check input
  if (isempty (name))
    list = pkg ("list");
    for k = 1:length (list)
      generate_package_html (list {k}.name, outdir, options);
    endfor
    return;
  elseif (isstruct (name))
    desc = name;
    if (isfield (name, "name"))
      packname = desc.name;
    else
      packname = "";
    endif
  elseif (ischar (name))
    packname = name;
    pkg ("load", name);
    desc = pkg ("describe", name) {1};
  else
    error (["generate_package_html: first input must either be the name of a ", ...
            "package, or a structure giving its description."]);
  endif
  
  if (isempty (outdir))
    outdir = packname;
  elseif (!ischar (outdir))
    error ("generate_package_html: second input argument must be a string");
  endif
  
  ## Create output directory if needed
  if (!exist (outdir, "dir"))
    mkdir (outdir);
  endif

  packdir = fullfile (outdir, packname);
  if (!exist (packdir, "dir"))
    mkdir (packdir);
  endif

  [local_fundir, fundir] = mk_function_dir (packdir, packname, options);
  
  ## If options is a string, call get_html_options
  if (ischar (options))
    options = get_html_options (options);
  elseif (!isstruct (options))
    error ("generate_package_html: third input argument must be a string or a structure");
  endif
  
  ##################################################  
  ## Generate html pages for individual functions ##
  ##################################################

  ## Set javascript startup
  if (!isfield (options, "body_command"))
    if (isfield (options, "pack_body_cmd"))
      options.body_command = options.pack_body_cmd;
    else
      options.body_command = "";
    endif
  endif

  options.footer = strrep (options.footer, "%package", packname);

  num_categories = length (desc.provides);
  anchors = implemented = cell (1, num_categories);
  for k = 1:num_categories
    F = desc.provides {k}.functions;
    category = desc.provides {k}.category;
    anchors {k} = strrep (category, " ", ""); # anchor names
   
    ## For each function in category
    num_functions = length (F);
    implemented {k} = cell (1, num_functions);
    for l = 1:num_functions
      fun = F {l};
      if (any (fun == filesep ()))
        at_dir = fileparts (fun);
        mkdir (fullfile (fundir, at_dir));
        r = "../../../";
      else
        r = "../../";
      endif
      outname = fullfile (fundir, sprintf ("%s.html", fun));
      try
        html_help_text (fun, outname, options, r);
        implemented {k}{l} = true;
      catch
        warning ("marking '%s' as not implemented", fun);
        implemented {k}{l} = false;
     end_try_catch
    endfor
  endfor  

  #########################
  ## Write overview file ##
  #########################
  first_sentences = cell (1, num_categories);
  if (isfield (options, "include_overview") && options.include_overview)
    overview_filename = get_overview_filename (options, desc.name);

    fid = fopen (fullfile (packdir, overview_filename), "w");
    if (fid < 0)
      error ("generate_package_html: couldn't open overview file for writing");
    endif
  
    [header, title, footer] = get_overview_header_title_and_footer (options, desc.name, "../");

    fprintf (fid, "%s\n", header);  
    fprintf (fid, "<h2 class=\"tbdesc\">%s</h2>\n\n", desc.name);

    fprintf (fid, "  <div class=\"package_description\">\n");
    fprintf (fid, "    %s\n", desc.description);
    fprintf (fid, "  </div>\n\n");
  
    fprintf (fid, "<p>Select category:  <select name=\"cat\" onchange=\"location = this.options[this.selectedIndex].value;\">\n");
    for k = 1:num_categories
      category = desc.provides {k}.category;
      fprintf (fid, "    <option value=\"#%s\">%s</option>\n", anchors {k}, category);
    endfor
    fprintf (fid, "  </select></p>\n\n");
  
    ## Generate function list by category
    for k = 1:num_categories
      F = desc.provides {k}.functions;
      category = desc.provides {k}.category;
      fprintf (fid, "  <h3 class=\"category\"><a name=\"%s\">%s</a></h3>\n\n",
               anchors {k}, category);
  
      first_sentences {k} = cell (1, length (F));
      
      ## For each function in category
      for l = 1:length (F)
        fun = F {l};
        if (implemented {k}{l})
          first_sentences {k}{l} = get_first_help_sentence (fun, 200);
          first_sentences {k}{l} = strrep (first_sentences {k}{l}, "\n", " ");
          
          link = sprintf ("%s/%s.html", local_fundir, fun);
          fprintf (fid, "    <div class=\"func\"><b><a href=\"%s\">%s</a></b></div>\n",
                   link, fun);
          fprintf (fid, "    <div class=\"ftext\">%s</div>\n\n", first_sentences {k}{l});
        else
          fprintf (fid, "    <div class=\"func\"><b>%s</b></div>\n", fun);
          fprintf (fid, "    <div class=\"ftext\">Not implemented.</div>\n\n");
        endif
      endfor
    endfor
  
    fprintf (fid, "\n%s\n", footer);
    fclose (fid);
  endif
  
  ################################################
  ## Write function data for alphabetical lists ##
  ################################################
  if (isfield (options, "include_alpha") && options.include_alpha)
    for letter = "a":"z"
      [name_filename, desc_filename] = get_alpha_database (outdir, desc.name, letter);
      name_fid = fopen (name_filename, "w");
      desc_fid = fopen (desc_filename, "w");
      if (name_fid == -1 || desc_fid == -1)
        error ("generate_package_html: could not open alphabet database for writing");
      endif
      
      for k = 1:num_categories
        F = desc.provides {k}.functions;
        for l = 1:length (F)
          fun = F {l};
          if (implemented {k}{l} && lower (fun (1)) == letter)
            fs = first_sentences {k}{l};
            
            fprintf (name_fid, "%s\n", fun);
            fprintf (desc_fid, "%s\n", fs);
          endif
        endfor
      endfor
      
      fclose (name_fid);
      fclose (desc_fid);
    endfor
  endif  
  
  #####################################################
  ## Write short description for forge overview page ##
  #####################################################
  
  if (isfield (options, "include_package_list_item") && options.include_package_list_item)
    pkg_list_item_filename = get_pkg_list_item_filename (desc.name, outdir);

    text = strrep (options.package_list_item, "%name", desc.name);
    text = strrep (text, "%version", desc.version);
    text = strrep (text, "%extension", "tar.gz");
    text = strrep (text, "%shortdescription", desc.description);

    fid = fopen (pkg_list_item_filename, "w");
    if (fid > 0)
      fprintf (fid, text);
      fclose (fid);
    else
      error ("generate_package_html: unable to open file %s.", pkg_list_item_filename);
    endif
  endif

  ######################
  ## Write index file ##
  ######################
  if (isfield (options, "include_package_page") && options.include_package_page)
    ## Get detailed information about the package
    all_list = pkg ("list");
    list = [];
    for k = 1:length (all_list)
      if (strcmp (all_list {k}.name, packname))
        list = all_list {k};
      endif
    endfor
    if (isempty (list))
      error ("generate_package_html: couldn't locate package '%s'", packname);
    endif

    ## Open output file
    index_filename = "index.html";

    fid = fopen (fullfile (packdir, index_filename), "w");
    if (fid < 0)
      error ("generate_package_html: couldn't open index file for writing");
    endif
  
    ## Write output
    [header, title, footer] = get_index_header_title_and_footer (options, desc.name, "../");

    fprintf (fid, "%s\n", header); 
    fprintf (fid, "<h2 class=\"tbdesc\">%s</h2>\n\n", desc.name);

    fprintf (fid, "<table>\n");
    fprintf (fid, "<tr><td rowspan=\"2\" class=\"box_table\">\n");
    fprintf (fid, "<div class=\"package_box\">\n");
    fprintf (fid, "  <div class=\"package_box_header\"></div>\n");
    fprintf (fid, "  <div class=\"package_box_contents\">\n");
    fprintf (fid, "    <table>\n");
    fprintf (fid, "      <tr><td class=\"package_table\">Package Version:</td><td>%s</td></tr>\n",
            list.version);
    fprintf (fid, "      <tr><td class=\"package_table\">Last Release Date:</td><td>%s</td></tr>\n",
             list.date);
    fprintf (fid, "      <tr><td class=\"package_table\">Package Author:</td><td>%s</td></tr>\n",
             list.author);
    fprintf (fid, "      <tr><td class=\"package_table\">Package Maintainer:</td><td>%s</td></tr>\n",
             list.maintainer);
    fprintf (fid, "      <tr><td class=\"package_table\">License:</td><td><a href=\"COPYING.html\">");
    if (isfield (list, "license"))
      fprintf (fid, "%s</a></td></tr>\n", list.license);
    else
      fprintf (fid, "Read license</a></td></tr>\n");
    endif
    fprintf (fid, "    </table>\n");
    fprintf (fid, "  </div>\n");
    fprintf (fid, "</div>\n");
    fprintf (fid, "</td>\n\n");
    
    fprintf (fid, "<td>\n");
    if (isfield (options, "download_link"))
      fprintf (fid, "<div class=\"download_package\">\n");
      fprintf (fid, "  <table><tr><td>\n");
      fprintf (fid, "    <img src=\"../download.png\"/>\n");
      fprintf (fid, "  </td><td>\n");
      link = strrep (options.download_link, "%name", desc.name);
      link = strrep (link, "%version", desc.version);
      fprintf (fid, "    <a href=\"%s\"\n", link);
      fprintf (fid, "     class=\"download_link\">\n");
      fprintf (fid, "      Download Package\n");
      fprintf (fid, "    </a><br>\n");
      fprintf (fid, "    <a href=\"http://sourceforge.net/projects/octave/files/\"");
      fprintf (fid, " class=\"older_versions_download\">(older versions)</a>\n");
      fprintf (fid, "  </td></tr></table>\n");
      fprintf (fid, "</div>\n");
    endif
    fprintf (fid, "</td></tr>\n");
    fprintf (fid, "<tr><td>\n");
    fprintf (fid, "<div class=\"package_function_reference\">\n");
    fprintf (fid, "  <table><tr><td>\n");
    fprintf (fid, "    <img src=\"../doc.png\"/>\n");
    fprintf (fid, "  </td><td>\n");
    fprintf (fid, "    <a href=\"%s\" class=\"function_reference_link\">\n", overview_filename);
    fprintf (fid, "      Function Reference\n");
    fprintf (fid, "    </a>\n");
    fprintf (fid, "  </td></tr></table>\n");
    fprintf (fid, "</div>\n");
    fprintf (fid, "</td></tr>\n");
    fprintf (fid, "</table>\n\n");

    fprintf (fid, "<h3>Description</h3>\n");
    fprintf (fid, "  <div id=\"description_box\">\n")
    fprintf (fid, list.description);
    fprintf (fid, "  </div>\n\n")

    fprintf (fid, "<h3>Details</h3>\n");
    fprintf (fid, "  <table id=\"extra_package_table\">\n");
    
    if (isfield (list, "depends"))
      fprintf (fid, "    <tr><td>Dependencies: </td><td>\n");
      for k = 1:length (list.depends)
        p = list.depends {k}.package;
        if (isfield (list.depends {k}, "operator") && isfield (list.depends {k}, "version"))
          o = list.depends {k}.operator;
          v = list.depends {k}.version;
          vt = sprintf ("(%s %s) ", o, v);
        else
          vt = "";
        endif
      
        if (strcmpi (p, "octave"))
          fprintf (fid, "<a href=\"http://www.octave.org\">Octave</a> ");
        else
          fprintf (fid, "<a href=\"../%s/index.html\">%s</a> ", p, p);
        endif
        fprintf (fid, vt);
      endfor
      fprintf (fid, "</td></tr>\n");
    endif
  
    if (isfield (list, "buildrequires"))
      fprintf (fid, "    <tr><td>Build Dependencies:</td><td>%s</td></tr>\n", list.buildrequires);
    endif

    ## if the package does not specify, then it is not autoloaded. Also, sometimes
    ## the value is 1 (true) but other times the value is a string
    if (isfield (list, "autoload") && (list.autoload == 1 ||
                                       any (strcmpi ({"yes", "on", "true"}, list.autoload))))
      a = "Yes";
    else
      a = "No";
    endif
    fprintf (fid, "    <tr><td>Autoload:</td><td>%s</td></tr>\n", a);
  
    fprintf (fid, "  </table>\n\n");
  
    fprintf (fid, "\n%s\n", footer);
    fclose (fid);
  endif

  ######################
  ## Write COPYING file ##
  ######################
  if (isfield (options, "include_package_license") && options.include_package_license)
    ## Get detailed information about the package
    all_list = pkg ("list");
    list = [];
    for k = 1:length (all_list)
      if (strcmp (all_list {k}.name, packname))
        list = all_list {k};
      endif
    endfor
    if (isempty (list))
      error ("generate_package_html: couldn't locate package '%s'", packname);
    endif

    ## Read license
    filename = fullfile (list.dir, "packinfo", "COPYING");
    fid = fopen (filename, "r");
    if (fid < 0)
      error ("generate_package_html: couldn't open license for reading");
    endif
    contents = char (fread (fid).');
    fclose (fid);

    ## Open output file
    copying_filename = "COPYING.html";

    fid = fopen (fullfile (packdir, copying_filename), "w");
    if (fid < 0)
      error ("generate_package_html: couldn't open COPYING file for writing");
    endif
  
    ## Write output
    [header, title, footer] = get_index_header_title_and_footer (options, desc.name, "../");
    
    fprintf (fid, "%s\n", header); 
    fprintf (fid, "<h2 class=\"tbdesc\">License for '%s' Package</h2>\n\n", desc.name);
    fprintf (fid, "<p><a href=\"index.html\">Return to the '%s' package</a></p>\n\n", desc.name);

    fprintf (fid, "<pre>%s</pre>\n\n", contents);
    
    fprintf (fid, "\n%s\n", footer);
    fclose (fid);
  endif
endfunction
