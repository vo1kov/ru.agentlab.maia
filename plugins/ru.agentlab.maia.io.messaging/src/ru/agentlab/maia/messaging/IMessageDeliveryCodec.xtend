package ru.agentlab.maia.messaging

interface IMessageDeliveryCodec {

	/**
	 *      Encodes an <code>IMessage</code> object into a byte sequence,
	 *      according to the specific message representation.
	 *      @param message The ACL message to encode.
	 *      @param charset Charset encoding to use (e.g. US_ASCII, UTF-8, etc)
	 *      @return a byte array, containing the encoded message.
	 */
	def byte[] encode(IMessage message, String charset)

	/**
	 *    Recovers an <code>ACLMessage</code> object back from raw data,
	 *    using the specific message representation to interpret the byte
	 *    sequence.
	 *    @param data The byte sequence containing the encoded message.
	 *    @param charset Charset encoding to use (e.g. US_ASCII, UTF-8, etc)
	 *    @return A new <code>IMessage</code> object, built from the raw
	 *    data.
	 */
	def IMessage decode(byte[] data, String charset)
}