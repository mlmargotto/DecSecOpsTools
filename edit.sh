sed -i 's/<!-- wp:paragraph -->//g' edit.md
sed -i 's/<!-- \/wp:paragraph -->//g' edit.md
sed -i 's/<!-- wp:preformatted -->//g' edit.md
sed -i 's/<!-- \/wp:preformatted -->//g' edit.md
sed -i 's/<p>//g' edit.md
sed -i 's/<\/p>//g' edit.md
sed -i 's/\&nbsp;/ /g' edit.md
sed -i 's/<pre class="wp-block-preformatted">/```\n/g' edit.md
sed -i 's/<\/pre>/\n```/g' edit.md
sed -i 's/<br>/\n/g' edit.md
sed -i 's/<!-- wp:heading {"level":1} -->//g' edit.md
sed -i 's/<!-- \/wp:heading -->//g' edit.md
sed -i 's/<h1>/# /g' edit.md
sed -i 's/<\/h1>//g' edit.md
sed -i 's/<!-- wp:heading -->//g' edit.md
sed -i 's/<h2>/## /g' edit.md
sed -i 's/<\/h2>//g' edit.md
sed -i 's/<!-- wp:list -->//g' edit.md
sed -i 's/<!-- \/wp:list -->//g' edit.md
#sed -i 's/<ul>/\n/g' edit.md
#sed -i 's/<\/ul>/\n/g' edit.md
#sed -i 's/^.*<li>/\* /g' edit.md
#sed -i 's/<\/li>/\n/g' edit.md
sed -i 's/<strong>/**/g' edit.md
sed -i 's/<\/strong>/**/g' edit.md
sed -i 's/&gt;/>/g' edit.md
sed -i 's/&amp;/\&/g' edit.md
sed -i 's/&lt;/</g' edit.md
#sed -i 's/<ol>/\n/g' edit.md
#sed -i 's/<\/ol>/\n/g' edit.md
sed -i 's/<!-- \/wp:table -->//g' edit.md
sed -i 's/<code>/```\n/g' edit.md
sed -i 's/<\/code>/\n```/g' edit.md

# sed -i 's/<h1>/# /g' edit.md
