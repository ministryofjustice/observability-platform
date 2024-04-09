#!/usr/bin/env bash

# Directories
scripts_dir="$(dirname "$0")"
adr_directory="${scripts_dir}/../source/documentation/architecture-decision-records"

# Ensure the ADR directory exists
if [ ! -d "$adr_directory" ]; then
  echo "The architecture-decision-records directory does not exist."
  exit 1
fi

# Detect the next ADR number
latest_adr_number=$(find "$adr_directory" -type f -name '*.html.md.erb' | sed -E 's/.*\/([0-9]+)-.*/\1/' | sort -n | tail -n 1)
next_adr_number=$((latest_adr_number + 1))
formatted_next_adr_number=$(printf "%04d" $next_adr_number)

# User inputs
echo -n 'Enter the ADR title: '
read -r adr_title
echo -n 'Enter the Proposer'\''s name: '
read -r proposer_name

# Date
current_date=$(date +%Y-%m-%d)

# Filename
slugified_title=$(echo "$adr_title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
filename="${adr_directory}/${formatted_next_adr_number}-${slugified_title}.html.md.erb"

# Template path
template_path="${scripts_dir}/adr-template.html.md.erb"

# Validate template exists
if [ ! -f "$template_path" ]; then
  echo "The template file adr-template.html.md.erb does not exist."
  exit 1
fi

# Read and modify the template
modified_content=$(awk -v title="$adr_title" -v date="$current_date" -v proposer="$proposer_name" -v adr_id="$formatted_next_adr_number" '
    BEGIN { OFS=FS=":" }
    {
        gsub(/<title>/, title);
        gsub(/<current-date>/, date);
        gsub(/<proposer>/, proposer);
        gsub(/<id>/, adr_id);
    }
    /<%= current_page.data.title %>/{ gsub(/0001/, adr_id); }
    { print }' "$template_path")

# Write the modified content to the new file
echo "$modified_content" >"$filename"

echo "Template created: $filename"

# Construct the new line for the ADR log
new_adr_log_entry="| [${formatted_next_adr_number}](/documentation/architecture-decision-records/${formatted_next_adr_number}-${slugified_title}.html) | ${adr_title} | 🤔 Proposed |"

# File path for the ADR log index
adr_log_index="${adr_directory}/index.html.md.erb"

# Check if the ADR log index file exists
if [ ! -f "$adr_log_index" ]; then
  echo "The ADR log index file does not exist."
  exit 1
fi

# Append the new ADR log entry to the table in the index file
awk -v new_entry="$new_adr_log_entry" '
    /^[\t ]*$/ {
        # Skip blank lines: lines that are empty or contain only whitespace (tabs/spaces)
        next;
    }
    /## Statuses/ {
        print new_entry; # Print the new entry
        print ""; # Ensure a blank line after the new entry
    }
    { print } # Print all other lines
' "$adr_log_index" >temp && mv temp "$adr_log_index"

echo "Added new ADR log entry to the index file."
