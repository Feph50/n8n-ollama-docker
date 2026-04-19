# n8n-Ollama-Docker
How to integrate automation system n8n with local LLM (Ollama)

**Prerequisites:**
* Docker and Docker Compose installed.
* An NVIDIA GPU with [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) installed (Script automatically detects and uses your GPU).
* Git installed.

**Note:** Container size (with data) is approximately 17.7 GB.

### Step 1: Clone the repository
Copy and paste this command into CLI.
```bash
git clone https://github.com/Feph50/n8n-ollama-docker
```

### Step 2: Authorize and Run the Container
Execute the following command in the project's root directory.

**Note**: this process initially lasts 15-20 minutes because system need to pull base images (Pytorch) and install dependencies.

```bash
chmod +x run.sh
./run.sh
```

After running this, you will be dropped into the container's interactive shell (root@container-id:/app#).
### Step 3: Pull Model
Run the following command:
```bash
# 1. Start Ollama service in the background
ollama serve &

# 2. Pull the Qwen 2.5 (3B) model
ollama pull qwen2.5:3b
```
This command will pull LLM. In this guide, Qwen2.5:3b is configured by default for basic inference tasks. You can replace it with models with more parameters depending on your device.


### Step 4: Start n8n

Execute the following command to start n8n
```bash
n8n
```

### Step 5: Setup n8n through local website

Connect to this n8n's localhost and sign up basic information.
```link
http://localhost:5678/
```

### Step 6: Connect n8n with Ollama

1. Press `N` on your keyboard (to create nodes in n8n) and search for **Basic LLM Chain**

![image](https://hackmd.io/_uploads/SypuCQMa-l.png)

2. Press `Esc` and click the `+` under **Basic LLM Chain** node
![image](https://hackmd.io/_uploads/HkphCmzpZe.png)

3. Search for `Ollama Model` and configure it as follows:

* Model: `qwen2.5:3b`
* Click **Set up credential** and save to activate local Ollama instance.
![image](https://hackmd.io/_uploads/BksRA7fpWx.png)


4. Your workflow should looke like this:
![image](https://hackmd.io/_uploads/BkpXJEzaWe.png)


🎉 **Done:** The LLM Node is now ready to process inputs from your n8n workflow. You can start by building small automation projects (e.g., summarizing Telegram notifications, processing emails, etc.).


### 💡 Example Use Case:

This is the project I built recently with LLM Nodes to crawl price of BTC, news and notify to my Telegram:
![image](https://hackmd.io/_uploads/HyLJg4Mp-e.png)

