import React, { useState, useEffect } from "react";
import "../styles/Messages.css";
import { useNavigate } from "react-router-dom";

type Chat = {
  id: number;
  username: string;
  lastMessage: string;
  color: string;
};

type Message = {
  id: number;
  sender: string;
  text: string;
};

const Messages: React.FC = () => {
  const [chats] = useState<Chat[]>([
    { id: 1, username: "user.name", lastMessage: "Continuar conversación", color: "#6C63FF" },
    { id: 2, username: "user.name", lastMessage: "Continuar conversación", color: "#FF4D4D" },
    { id: 3, username: "user.name", lastMessage: "Continuar conversación", color: "#4DBEFF" },
    { id: 4, username: "user.name", lastMessage: "Continuar conversación", color: "#FFA726" },
  ]);

  const [selectedChat, setSelectedChat] = useState<Chat | null>(null);
  const [messages, setMessages] = useState<Message[]>([]);
  const [newMessage, setNewMessage] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    if (selectedChat) {
      setMessages([
        { id: 1, sender: selectedChat.username, text: "Hola, ¿cómo estás?" },
        { id: 2, sender: "yo", text: "Todo bien, ¿y tú?" },
      ]);
    }
  }, [selectedChat]);

  const handleSend = () => {
    if (newMessage.trim() !== "") {
      setMessages([...messages, { id: Date.now(), sender: "yo", text: newMessage }]);
      setNewMessage("");
    }
  };

  return (
    <div className="messages-layout">
      {/* Panel izquierdo */}
      <div className="sidebar-chats">
        {chats.map((chat) => (
          <div
            key={chat.id}
            className={`chat-card ${selectedChat?.id === chat.id ? "active" : ""}`}
            style={{ borderColor: chat.color }}
            onClick={() => setSelectedChat(chat)}
          >
            <div className="chat-avatar"></div>
            <div className="chat-info">
              <span className="chat-user">@{chat.username}</span>
              <span className="chat-last">{chat.lastMessage}</span>
            </div>
          </div>
        ))}
      </div>

      {/* Panel central */}
      <div className="chat-panel">
        {selectedChat ? (
          <>
            <div className="chat-header">
              <span className="chat-header-user">@{selectedChat.username}</span>
            </div>

            <div className="chat-body">
              {messages.map((msg) => (
                <div
                  key={msg.id}
                  className={`bubble ${msg.sender === "yo" ? "bubble-me" : "bubble-other"}`}
                >
                  {msg.text}
                </div>
              ))}
            </div>

            <div className="chat-input-box">
              <input
                type="text"
                placeholder="Aa"
                value={newMessage}
                onChange={(e) => setNewMessage(e.target.value)}
              />
              <button onClick={handleSend}>Enviar</button>
            </div>
          </>
        ) : (
          <div className="empty-chat">Selecciona un chat</div>
        )}
      </div>

      {/* Panel derecho de iconos */}
      <div className="sidebar-icons">
        <div className="icons-group">
          <i className="fas fa-bell"></i>
          <i className="fas fa-user"></i>
          <i className="fas fa-comments"></i>
          <i className="fas fa-cog"></i>
        </div>

        <div className="icons-group">
          <i className="fas fa-home" onClick={() => navigate("/principal")}></i>
          <i className="fas fa-search"></i>
          <i className="fas fa-th"></i>
          <i className="fas fa-image"></i>
        </div>
      </div>
    </div>
  );
};

export default Messages;
