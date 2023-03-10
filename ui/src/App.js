import React from "react";
import Chat, { Bubble, useMessages } from "./chatui/index";
import {useCookies} from 'react-cookie';
import {default as axios} from "axios";

export default function App() {
    const {messages, appendMsg, setTyping} = useMessages([]);
    const axios = require('axios').default;
    const [cookies, setCookie, removeCookie] = useCookies(['userId']);
    const short = require('short-uuid');

    function getTempId() {
        if (cookies.userId) return cookies.userId; else {
            const userId = short.generate();
            setCookie("userId", userId);
            return userId;
        }
    }

    function handleSend(type, val) {
        if (type === "text" && val.trim()) {
            appendMsg({
                type: "text", content: {text: val}, position: "right",
                user: {avatar: 'static/user-80.png'},
                src: "user"
            });
            // setTyping(false);

            axios.post('/v1/chat/completions', {
                msg: val, userId: getTempId()
            })
                .then(function (response) {
                    console.log('请求成功');
                    console.log(response);
                    appendMsg({
                        type: "text",
                        content: {text: response.data.choices[0].message.content},
                        user: {avatar: "static/ChatGPT_logo.png"},
                        src: "chatGPT"
                    });
                })
                .catch(function (error) {
                    appendMsg({
                        type: "text", content: {text: error.toString()},
                        user: {avatar: "static/ChatGPT_logo.png"},
                        src: "chatGPT"
                    });
                    console.log(error);
                });
        }
    }


    function renderMessageContent(msg) {
        const {content} = msg;
        return <Bubble content={content.text}/>;
    }


    return (<Chat id={"left"}
                  width={"50%"}
                  navbar={{title: "智能助理：写作、翻译、写代码、阅读理解、文档摘要、口语书面化、百科问答"}}
                  messages={messages}
                  renderMessageContent={renderMessageContent}
                  onSend={handleSend}
    />);
}
