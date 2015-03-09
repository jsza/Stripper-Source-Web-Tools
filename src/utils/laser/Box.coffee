objectToStripper = (object) ->
    result = ''
    for key, value of object
        result += '    "' + key + '" "' + value + '"\n'
    return '{\n' + result + '}'



mapToVector = (s) ->
    return s.split(' ').map(
        (thing) ->
            return parseFloat(thing)
    )



makeBeam = (targetname, start, end, width, color, texture) ->
    console.log targetname
    return {
        'classname': 'env_beam'
        'targetname': targetname
        'BoltWidth': width
        'LightningStart': start
        'LightningEnd': end
        'rendercolor': color.join(' ')
        'texture': texture
        'origin': '0 0 0'
        'life': 0
        'spawnflags': '1'
        'StrikeTime': '0'
        'TextureScroll': 0
    }



makeTarget = (targetname, origin) ->
    return {
        'classname': 'info_target'
        'targetname': targetname
        'origin': origin.join(' ')
    }



addVectors = (v1, v2) ->
    return v1.map(
        (a, i) -> return a + v2[i])



class Box
    defaultWidth: 4.0
    defaultTexture: 'materials/effects/blueblacklargebeam.vmt'
    defaultColor: '255 0 0'

    constructor: (identifier, origin, size, width, color, texture) ->
        @identifier = identifier.trim()
        @origin = mapToVector(origin.trim())
        @size = mapToVector(size.trim())
        @width = parseFloat((width or '').trim()) or @defaultWidth
        @color = mapToVector((color or @defaultColor).trim())
        @texture = (texture or @defaultTexture).trim()


    getCorners: ->
        x = @size.map((i) -> i/2)
        s = {x: x[0], y: x[1], z: x[2]}

        return {
            t1: addVectors(@origin, [s.x,  s.y,  s.z])
            t2: addVectors(@origin, [-s.x, s.y,  s.z])
            t3: addVectors(@origin, [-s.x, -s.y, s.z])
            t4: addVectors(@origin, [s.x,  -s.y, s.z])
            b1: addVectors(@origin, [s.x,  s.y,  -s.z])
            b2: addVectors(@origin, [-s.x, s.y,  -s.z])
            b3: addVectors(@origin, [-s.x, -s.y, -s.z])
            b4: addVectors(@origin, [s.x,  -s.y, -s.z])
        }


    renderStripperCode: ->
        result = []
        c = @getCorners()

        for k, v of c
            result.push(makeTarget((@identifier + k), v))

        b = [
            # Top
            ['t1', 't2'],
            ['t2', 't3'],
            ['t3', 't4'],
            ['t4', 't1'],
            # Bottom
            ['b1', 'b2'],
            ['b2', 'b3'],
            ['b3', 'b4'],
            ['b4', 'b1'],
            # Top to bottom
            ['t1', 'b1'],
            ['t2', 'b2'],
            ['t3', 'b3'],
            ['t4', 'b4']
        ]

        for [start, end] in b
            result.push(@makeBeam(start, end))

        return result.map(objectToStripper).join('\n')


    makeBeam: (start, end) ->
        return makeBeam(
            (@identifier + 'beam' + start + end), (@identifier + start),
            (@identifier + end), @width, @color,
            @texture)



module.exports = Box
