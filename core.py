import openai


class Message:

    def __init__(self, role, content):
        self.role = role
        self.content = content

    def message(self):
        return {"role": self.role, "content": self.content}


class Assistant:

    def __init__(self):
        self.conversation_history = []

    def _get_assistant_response(self, prompt):

        try:
            completion = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",
                messages=prompt
            )

            response_message = Message(completion['choices'][0]['message']['role'],
                                       completion['choices'][0]['message']['content'])
            return response_message.message()

        except Exception as e:

            return f'Request failed with exception {e}'

    def ask_assistant(self, next_user_prompt):
        [self.conversation_history.append(x) for x in next_user_prompt]
        assistant_response = self._get_assistant_response(self.conversation_history)
        self.conversation_history.append(assistant_response)
        return assistant_response

USERS_CONVERSION = dict()


def get_assistant(user_id):
    ua = USERS_CONVERSION.get(user_id)
    if ua is None:
        ua = Assistant()
        USERS_CONVERSION[user_id] = ua
    return ua
