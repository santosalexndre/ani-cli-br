BUILD_DIR="./dist"

echo "cleaning old build..."
rm -r "$BUILD_DIR"

yue . -t "$BUILD_DIR"

YUE_EXIT=$?

if [ $YUE_EXIT -ne 0 ]; then
    echo ""
    echo "Yue compilation failed."
    rm -r $BUILD_DIR
    exit $YUE_EXIT
fi

find . -type f -name "*.lua" -not -path "*/$BUILD_DIR/*" -exec cp --parents {} "$BUILD_DIR" \;

pushd dist
~/.local/bin/luvi . -o exe
popd
