import subprocess
import gradio as gr

# Function to call `ollama` with user input
def run_deepseek(prompt):
    try:
        # Run the ollama command with subprocess
        command = ["ollama", "run", "deepseek-r1:1.5b", "-p", prompt]
        result = subprocess.run(command, capture_output=True, text=True)

        # Check for errors
        if result.returncode != 0:
            return f"Error: {result.stderr}"

        # Return the output
        return result.stdout
    except Exception as e:
        return f"An error occurred: {e}"

# Gradio Interface
interface = gr.Interface(
    fn=run_deepseek,
    inputs=gr.Textbox(lines=2, placeholder="Enter your prompt here..."),
    outputs=gr.Textbox(label="DeepSeek Output"),
    title="DeepSeek Runner",
    description="Run the DeepSeek-R1 model (1.5b) using Ollama.",
)

# Launch the interface
if __name__ == "__main__":
    interface.launch()
