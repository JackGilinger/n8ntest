import React, { useState } from 'react';

function App() {
  const [input, setInput] = useState("");

  const handleClick = (value) => {
    if (value === "=") {
      try {
        setInput(eval(input).toString());
      } catch {
        setInput("Error");
      }
    } else if (value === "C") {
      setInput("");
    } else {
      setInput(input + value);
    }
  };

  return (
    <div className="bg-gradient-to-br from-blue-400 to-indigo-600 h-screen flex flex-col items-center justify-center font-sans px-4">
      <div className="text-white text-3xl mb-6 font-semibold">Калькулятор</div>
      <div className="bg-white bg-opacity-30 rounded-lg shadow-lg p-6 w-full max-w-sm">
        <input
          type="text"
          value={input}
          className="w-full text-right px-2 py-4 rounded-lg shadow-inner bg-gray-200 mb-4 text-xl"
          disabled
        />
        <div className="grid grid-cols-4 gap-2">
          {['C', '/', '*', '-', '7', '8', '9', '+', '4', '5', '6', '=', '1', '2', '3', '0', '.'].map(key => (
            <button
              className="bg-blue-500 text-white py-3 rounded-lg shadow-md hover:bg-blue-600 active:bg-blue-700 transition-colors duration-150"
              key={key}
              onClick={() => handleClick(key)}
            >
              {key}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
}

export default App;