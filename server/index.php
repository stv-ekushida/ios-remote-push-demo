<?php
$deviceToken = '886948b2ac533cd29b48f19bdf5215be406f2f8c640596608718d32c871526f3';

$body = array();
$body['aps']['alert']['title'] = 'iOS10プッシュ通知テスト';
$body['aps']['alert']['subtitle'] = 'SubTitle';
$body['aps']['alert']['body'] = 'Body';
$body['aps']['sound'] = 'sound1.aiff';
$body['aps']['badge'] = 1;
$body['aps']['mutable-content'] = 1;
$body['image-url'] = 'https://s3-ap-northeast-1.amazonaws.com/qiita-image-store/0/71694/5e08632a6a84409c6ed692141608d10b47f22766/medium.png?1468746973';
$body['category'] = 'myNotificationCategory';


// SSL証明書
$cert = 'aps_dev.pem';
//$cert = 'aps_production.pem';

$url = 'ssl://gateway.sandbox.push.apple.com:2195'; // 開発用
//$url = 'ssl://gateway.push.apple.com:2195'; // 本番用

$context = stream_context_create();
stream_context_set_option( $context, 'ssl', 'local_cert', $cert );
$fp = stream_socket_client( $url, $err, $errstr, 60, STREAM_CLIENT_CONNECT, $context );

if( !$fp ) {

    echo 'Failed to connect.' . PHP_EOL;
    exit( 1 );

}

$payload = json_encode( $body );
$message = chr( 0 ) . pack( 'n', 32 ) . pack( 'H*', $deviceToken ) . pack( 'n', strlen($payload ) ) . $payload;

print 'send message:' . $payload . PHP_EOL;

fwrite( $fp, $message );
fclose( $fp );
echo 'end';