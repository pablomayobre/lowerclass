local class = require 'lowerclass'

describe('Default methods', function()
  local Object
  before_each(function()
    Object = class('Object')
  end)

  describe('name', function()
    it('is correctly set', function()
      assert.equal(Object.name, 'Object')
    end)
  end)

  describe('tostring', function()
    it('returns "class Object"', function()
      assert.equal(tostring(Object), 'class Object')
    end)
  end)

  describe('()', function()
    it('returns an object, like Object:new()', function()
      local obj = Object()
      assert.is_true(obj:isChildOf(Object))
    end)
  end)

  describe('subclass', function()

    it('throws an error when used without the :', function()
      assert.error(function() Object.subclass() end)
    end)

    it('throws an error when no name is given', function()
      assert.error( function() Object:subclass() end)
    end)

    describe('when given a class name', function()

      local SubClass

      before_each(function()
        SubClass = Object:subclass('SubClass')
      end)

      it('it returns a class with the correct name', function()
        assert.equal(SubClass.name, 'SubClass')
      end)

      it('it returns a class with the correct superclass', function()
        assert.equal(SubClass.super, Object)
      end)

      --[[
      it('it includes the subclass in the list of subclasses', function()
        assert.is_true(Object.subclasses[SubClass])
      end)
      ]]

    end)

  end)

  describe('instance creation', function()

    local SubClass

    before_each(function()
      SubClass = class('SubClass')
      function SubClass:initialize() self.mark=true end
    end)

    --[[
    describe('allocate', function()

      it('allocates instances properly', function()
        local instance = SubClass:allocate()
        assert.equal(instance.class, SubClass)
        assert.equal(tostring(instance), "instance of " .. tostring(SubClass))
      end)

      it('throws an error when used without the :', function()
        assert.error(Object.allocate)
      end)

      it('does not call the initializer', function()
        local allocated = SubClass:allocate()
        assert.is_nil(allocated.mark)
      end)

      it('can be overriden', function()

        local previousAllocate = SubClass.static.allocate

        function SubClass.static:allocate()
          local instance = previousAllocate(SubClass)
          instance.mark = true
          return instance
        end

        local allocated = SubClass:allocate()
        assert.is_true(allocated.mark)
      end)

    end)
    ]]

   describe('new', function()

      it('initializes instances properly', function()
        local instance = SubClass:new()
        assert.equal(instance.class, SubClass)
      end)

      it('throws an error when used without the :', function()
        assert.error(SubClass.new)
      end)

      it('calls the initializer', function()
        local initialized = SubClass:new()
        assert.is_true(initialized.mark)
      end)

    end)

    describe('isChildOf', function()

      describe('primitives', function()
        local o = Object:new()
        local primitives = {nil, 1, 'hello', {}, function() end, Object:new()}

        for _,primitive in pairs(primitives) do
          local theType = type(primitive)
          describe('A ' .. theType, function()
            it('object:isChildOf(, '.. theType ..') returns false', function()
              assert.is_false(o:isChildOf(primitive))
            end)
          end)
        end

      end)

      describe('An instance', function()
        local Class1 = class('Class1')
        local Class2 = class('Class2', Class1)
        local Class3 = class('Class3', Class2)
        local UnrelatedClass = class('Unrelated')

        local o1, o2, o3 = Class1:new(), Class2:new(), Class3:new()

        it('isChildOf its class', function()
          assert.is_true(o1:isChildOf(Class1))
          assert.is_true(o2:isChildOf(Class2))
          assert.is_true(o3:isChildOf(Class3))
        end)

        it('isChildOf its class\' superclasses', function()
          assert.is_true(o2:isChildOf(Class1))
          assert.is_true(o3:isChildOf(Class1))
          assert.is_true(o3:isChildOf(Class2))
        end)

        it('isChildOf its class\' subclasses', function()
          assert.is_false(o1:isChildOf(Class2))
          assert.is_false(o1:isChildOf(Class3))
          assert.is_false(o2:isChildOf(Class3))
        end)

        it('isChildOf an unrelated class', function()
          assert.is_false(o1:isChildOf(UnrelatedClass))
          assert.is_false(o2:isChildOf(UnrelatedClass))
          assert.is_false(o3:isChildOf(UnrelatedClass))
        end)

      end)

    end)

  end)

  describe('isChildOf', function()

    it('returns false for instances', function()
      assert.is_false(Object:isChildOf(Object:new()))
    end)

    describe('on primitives', function()
      local primitives = {nil, 1, 'hello', {}, function() end}

      for _,primitive in pairs(primitives) do
        local theType = type(primitive)
        it('returns false for ' .. theType, function()
          assert.is_false(Object:isChildOf(primitive))
        end)
      end

    end)

    describe('Any class (except Object)', function()
      local Class1 = class('Class1')
      local Class2 = class('Class2', Class1)
      local Class3 = class('Class3', Class2)
      local UnrelatedClass = class('Unrelated')

      it('is subclassOf its direct superclass', function()
        assert.is_true(Class2:isChildOf(Class1))
        assert.is_true(Class3:isChildOf(Class2))
      end)

      it('is subclassOf its ancestors', function()
        assert.is_true(Class3:isChildOf(Class1))
      end)

      it('is a subclassOf its class\' subclasses', function()
        assert.is_true(Class2:isChildOf(Class1))
        assert.is_true(Class3:isChildOf(Class1))
        assert.is_true(Class3:isChildOf(Class2))
      end)

      it('is not a subclassOf an unrelated class', function()
        assert.is_false(Class1:isChildOf(UnrelatedClass))
        assert.is_false(Class2:isChildOf(UnrelatedClass))
        assert.is_false(Class3:isChildOf(UnrelatedClass))
      end)

    end)
  end)
end)
