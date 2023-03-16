import React from "react";
import Chat, { Bubble, useMessages } from "./chatui/index";
import {useCookies} from 'react-cookie';
import {default as axios} from "axios";

export default function App() {
    const {messages, appendMsg, setTyping} = useMessages([]);
    const axios = require('axios').default;
    const [cookies, setCookie, removeCookie] = useCookies(['userId']);
    const short = require('short-uuid');
//    axios.defaults.withCredentials=true
//    axios.defaults.crossDomain=true

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
            setTimeout(() => {
                setTyping(true);
                axios.post('https://bxjv506qhj.execute-api.us-east-1.amazonaws.com/v1/chat/completions',
                {
                    msg: val, userId: getTempId()
                },
                {
                headers:{"Access-Control-Allow-Headers": "*",
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Credentials": true}
                }
                )
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
            }, 10);
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
