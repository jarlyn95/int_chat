# coding=utf-8
from flask import Flask, render_template, jsonify, request
import openai
# from flask_cors import CORS
from loguru import logger
from core import Assistant, Message, get_assistant

# USERS_CONVERSION = dict()

app = Flask(__name__, static_folder="./docs/static", template_folder="./docs",
            root_path='.')
# CORS(app)

openai.api_key = "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"  # supply your API key however you choose


@app.route("/")
def home():
    """
        当在浏览器访问网址时，通过 render_template 方法渲染 dist 文件夹中的 index.html。
        页面之间的跳转交给前端路由负责，后端不用再写大量的路由
    """
    return render_template('index.html')


@app.route('/v1/chat/completions', methods=["POST"])
def chat():
    msg = request.json.get("msg")
    user_id = request.json.get("userId")
    # uc = USERS_CONVERSION.get(user_id)
    # if uc is None:
    #     uc = Assistant()
    #     prompt = Message("user", msg)
    #     uc.ask_assistant(prompt)
    # else:
    #     uc.a
    prompt = Message("user", msg).message()
    ua = get_assistant(user_id)
    ret = ua.ask_assistant([prompt])

    # completion = openai.ChatCompletion.create(model="gpt-3.5-turbo",
    #                                           messages=[{"role": "user", "content": msg}])
    logger.info(ret)
    return jsonify(ret)


@app.route('/health', methods=["GET"])
def health():
    return jsonify({"msg": "ok", "status": 0})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
