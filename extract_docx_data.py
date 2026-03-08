import win32com.client
import os

def extract_docx_data(doc_path, content_md_path, comments_md_path):
    # Initialize Word application
    word = win32com.client.Dispatch("Word.Application")
    word.Visible = False
    
    try:
        # Open the document
        doc = word.Documents.Open(os.path.abspath(doc_path))
        
        # 1. Extract Main Content
        print("Extracting main content...")
        content_text = doc.Content.Text
        # Simple cleanup if needed, but win32com returns raw text with \r for newlines
        content_markdown = content_text.replace("\r", "\n")
        
        with open(content_md_path, "w", encoding="utf-8") as f:
            f.write("# 文档内容\n\n")
            f.write(content_markdown)
        print(f"Main content saved to {content_md_path}")
        
        # 2. Extract Comments and Annotations (Comments, Footnotes, Shapes)
        print("Extracting annotations (Comments, Footnotes, Shapes)...")
        annotations = []
        
        # Standard Comments
        if doc.Comments.Count > 0:
            annotations.append("## Word Comments\n")
            for comment in doc.Comments:
                author = comment.Author
                date = str(comment.Date)
                text = comment.Range.Text.replace("\r", " ").strip()
                annotations.append(f"### 作者: {author}\n**日期**: {date}\n\n**批注内容**: {text}\n\n---\n")
        
        # Footnotes
        if doc.Footnotes.Count > 0:
            annotations.append("## Footnotes\n")
            for i, fn in enumerate(doc.Footnotes):
                text = fn.Range.Text.replace("\r", " ").strip()
                annotations.append(f"### 脚注 {i+1}\n{text}\n\n")

        # Shapes (Often used for floating notes in templates)
        if doc.Shapes.Count > 0:
            annotations.append("## Shapes (Floating Annotations)\n")
            for i, shape in enumerate(doc.Shapes):
                try:
                    # Only try to get text if it has a text frame
                    if shape.TextFrame.HasText:
                        text = shape.TextFrame.TextRange.Text.replace("\r", "\n").strip()
                        if text:
                            annotations.append(f"### Shape {i+1}\n{text}\n\n")
                except Exception:
                    continue
        
        with open(comments_md_path, "w", encoding="utf-8") as f:
            f.write("# 文档批注与注释\n\n")
            if not annotations:
                f.write("没有找到批注、脚注或图形注释。\n")
            else:
                f.writelines(annotations)
        print(f"Annotations saved to {comments_md_path}")
        
        doc.Close(False)
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        word.Quit()

if __name__ == "__main__":
    base_dir = r"f:\Git_repo\SUEPTeX"
    input_file = os.path.join(base_dir, "模板.docx")
    content_file = os.path.join(base_dir, "内容.md")
    comments_file = os.path.join(base_dir, "批注.md")
    
    if os.path.exists(input_file):
        extract_docx_data(input_file, content_file, comments_file)
    else:
        print(f"File not found: {input_file}")
